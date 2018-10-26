#!/bin/bash
# Lets you unplug from power while your mac laptop is in clamshell mode without it going to sleep

function finish {
    sudo pmset -b disablesleep 0
    echo ""
    echo "Computer WILL sleep now on a lid close event."
}

echo "Disabling sleep requires an administrator password."
sudo pmset -b disablesleep 1 && trap finish EXIT && echo "Computer will NOT sleep now on a lid close event." && echo "You can now unplug safely and then press CTRL+C after." && while true; do sleep 10000; done
