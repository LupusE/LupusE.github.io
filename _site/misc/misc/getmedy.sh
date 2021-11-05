#!/bin/bash
#

for ext in `cat /home/lupus/tmp/date.csv`; do
 echo "w3m -dump http://www.medyatava.com/$ext"

  w3m -T text/plain http://www.medyatava.com/$ext > ~/tmp/out/$ext.txt

  if [ "x$?" = "x0" ]; then
    echo "$file  ..  OK";
  else
   echo "$file  ..  FAILED";
#   aplay /home/lupus_bkp/sys/bt/sniff/trifinite/tuned_nokia.wav;
  fi

## Make it more realistic, fake human behavior.
#  stime=$(($RANDOM%20))
#  echo "WILL SLEEP FOR $stime SECONDS"
#  sleep "$stime"s

done

