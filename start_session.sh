#!/bin/bash

if [ -f session.tmp ] ; then #check if there is already session activated
  echo "Alert:session is currently active"
  exit 1 #stop the execution 
fi

#start time for session
Start_Time=$(date '+%Y-%m-%d %H:%M:%S')
echo "START:$Start_Time" > session.tmp
echo "The session have started: $Start_Time" 

#start background timer for 45 minutes
(
 sleep 2700
#check if the session still active
 if [ -f session.tmp ]; then
 echo "Alert:it's been 45 minutes since the session, move aruond a bit and take a break"
 fi
)&
