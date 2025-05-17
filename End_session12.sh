O#!/bin/bash
if [ ! -f session.tmp ]; then
   echo "No active session found."
   exit 1
fi
   echo "Do you want to save the session? [y/n]"
   read answer
if [[ "$answer" != "y" ]]; then
   rm session.tmp
   echo "Session canceled without saving."
   exit 0
fi
START_TIME=$(grep "START:" session.tmp | sed 's/START://')
END_TIME=&(date '+%Y-%m-%d%H:%M:%S')

START_S=&(date -d "$START_TIME" +%s)
END_S=&(date -d "$END_TIME" +%s)
DURATION=$((END_S - START_S))

H=$((DURATION / 3600))
M=$(( (DURATION % 3600) / 60))
S=$((DURATION % 60))

LOG_LINE="Date: $(date '+%Y-%m-%d') | Start: $START_TIME | End: $END_TIME | Duration: ${H}h ${M}m ${S}s"

mkdir -p logs
touch logs/session_log.txt

if ! grep -q "$START_TIME" logs/session_log.txt; then
   echo "$LOG_LINE" >> logs/session_log.txt
   echo "Session saved:"
   echo "$LOG_LINE"
else 
   echo "Session already logged."
fi
rm session.tmp
