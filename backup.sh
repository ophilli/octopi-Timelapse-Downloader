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
    rsync --exclude 'tmp' -rzhe 'ssh -q' $USER@$i:/$RDIR $LDIR/$i
    #rsync --remove-source-files -avzhe ssh $USER@$i:/$RDIR $LDIR/$i

    if [ "$?" -eq "0" ]
    then
        echo "Backup of $i Successful: $(date)" >> ~/backup.log
    else
        echo "Backup of $i Failed: $(date)" >> ~/backup.log
    fi
done

rsync --exclude 'tmp' -rzhe 'ssh -q' pi@$LULZ:$LULZDIR $LDIR/$LULZ

if [ "$?" -eq "0" ]
then
    echo "Backup of $LULZ Successful: $(date)" >> ~/backup.log
else
    echo "Backup of $LULZ Failed: $(date)" >> ~/backup.log
fi

exit 0
