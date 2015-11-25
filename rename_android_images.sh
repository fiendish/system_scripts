#!/bin/bash
#
# Android phone camera keeps naming files stupidly. 
# File type already dictates that a video is a video.
# This makes it easier to sort by capture date online without relying on EXIF data that doesn't exist in all files.


for f in $1/*
do
   mv -n $f ${f/IMG_/}
   mv -n $f ${f/VID_/}
   mv -n $f ${f/PANO_/}
done
