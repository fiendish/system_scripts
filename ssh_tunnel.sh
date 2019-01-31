#!/bin/bash
####
# SSH tunnel internals. Works with 2FA.
# Make another .sh file containing...
####
# #!/bin/bash
# ./ssh_tunnel.sh myproxy.tld 2222 thing.pasttheproxy.tld 443 "THING server"
####
# chmod +x this. chmod +x the ^
# then double click the ^

PROXY=$1
PROXY_PORT=$2
DESTINATION=$3
DESTINATION_PORT=$4

if [ $# -lt 4 ]; then
    echo "Must pass in at least 4 arguments: PROXY, PROXY_PORT, DESTINATION, DESTINATION_PORT, [DESTINATION_NAME]"
    exit 1
fi

if [ -z "$5" ]; then
    DESTINATION_NAME="$DESTINATION:$DESTINATION_PORT"
else
    DESTINATION_NAME=$5
fi

if [ "$DESTINATION_PORT" -eq "443" ]; then
    PROTOCOL="https"
else
    PROTOCOL="http"
fi

LOCAL_PORT=1$4



CONTROL_SOCKET=$(mktemp)
rm "$CONTROL_SOCKET"  # delete file so the path can be used by ssh

function finish {
    ssh -S "$CONTROL_SOCKET" -O exit $PROXY
    rm "$CONTROL_SOCKET"
}
trap finish EXIT

echo "Connecting to $PROXY"
ssh -M -S "$CONTROL_SOCKET" -fNT -L $LOCAL_PORT:$DESTINATION:$4 $PROXY -p $2

# Having this echo happen after the connection succeeds makes this script much
# more complicated than it would be if we were just ending on the ssh
# invocation. (Wouldn't need the backgrounding + control socket stuff)
echo "$DESTINATION_NAME now available at $PROTOCOL://localhost:$LOCAL_PORT"

sleep 2147483647
