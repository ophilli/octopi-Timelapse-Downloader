#!/bin/bash
# Copyright: Owen Phillips 2016
# Description: A simple backup script for octoprint timelapses.
#              It is written with the Clemson Makerspace in mind,
#              and serves as a general introduction to bash scripting.
USER="****"
HOSTS=("****" "****" "****" "****")
RDIR="/home/octoprint/.octoprint/timelapse/"
LDIR="/mnt/MAKERSPACE/timelapse"
LULZ="****"
LULZDIR="/home/pi/.octoprint/timelapse/"

for i in "${HOSTS[@]}"; do
    rsync --remove-source-files -avzhe ssh $USER@$i:/$RDIR $LDIR/$i
done

rsync --exclude 'tmp' -rzhe 'ssh -q' pi@$LULZ:$LULZDIR $LDIR/$LULZ

exit 0
