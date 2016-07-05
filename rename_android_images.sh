#!/bin/bash
#
# Android phone camera keeps naming files stupidly. 
# File type already dictates that a video is a video.
# This makes it easier to sort by capture date online without relying on EXIF data that doesn't exist in video files.

function move_prefix {
   mv -n "$2" "`echo $2 | sed -r 's/('$1')_(.*)(\....)$/\2\3/'`"
}

function move_all_prefix {
   for f in $1/$2*
   do
      move_prefix "$2" "$f"
   done
}

move_all_prefix "$1" "VID"
exiv2 rename -t -F "$1"/*
