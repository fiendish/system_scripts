#!/bin/bash
# Android phone camera keeps naming files stupidly. 
# File type already dictates that a video is a video.

for f in $1/*
do
   mv -n $f ${f/IMG_/}
   mv -n $f ${f/VID_/}
   mv -n $f ${f/PANO_/}
done
