#!/bin/bash
#
# Mirror all images from der-flix.de
# image-url example: http://der-flix.de/autocartoons/763.jpg

for strip in `seq 1 763`; do
  file="$strip.jpg"
# echo "Get $file"

  wget -q "http://der-flix.de/autocartoons/$file"

  if [ "x$?" = "x0" ]; then
    echo "$file  ..  OK";
  else
   echo "$file  ..  FAILED";
   aplay /home/lupus_bkp/sys/bt/sniff/trifinite/tuned_nokia.wav;
  fi

## Make it more realistic, fake human behavior.
#  stime=$(($RANDOM%20))
#  echo "WILL SLEEP FOR $stime SECONDS"
#  sleep "$stime"s

done

