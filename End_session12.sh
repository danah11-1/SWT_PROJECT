#!/bin/bash
# Check if session.tmp file exists
if [ ! -f session.tmp ]; then
   echo "No active session found."
   exit
fi

 # Prompt user to save the session
  echo "Do you want to save the session? [y/n]"
   read answer
# Convert input to lowercase to handle uppercase "Y"
answer=$(echo "$answer" | tr '[ :upper: ]' '[ :lower: ]')
# If user chooses not to save, delete the session file 
if [[ "$answer" != "y" ]]; then
   rm session.tmp 
   echo "Session canceled without saving."
   exit 0
fi
# Extract START time from session.tmp
START_TIME=$(grep "START:" session.tmp | sed 's/START://')
# Get current time as End time (corrected data format)
END_TIME=$(date '+%Y-%m-%d %H:%M:%S')  

START_S=$(date -d "$START_TIME" +%s)
END_S=$(date -d "$END_TIME" +%s)
# Calculate duration in seconds

DURATION=$((END_S - START_S))
# Break down duration into hours, minutes, and seconds
H=$((DURATION / 3600))
M=$(( (DURATION % 3600) / 60 ))
S=$((DURATION % 60))



# Create log entry with proper formatting
LOG_LINE="Date: $(date '+%Y-%m-%d') | Start: $START_TIME | End: $END_TIME | Duration: ${H}h ${M}m ${S}s"
# Ensure logs directory exists

mkdir -p logs
touch logs/session_log.txt
# Check if session is already logged
if ! grep -q "$START_TIME" logs/session_log.txt; then
  # Save new session log
   echo "$LOG_LINE" >> logs/session_log.txt
   echo "Session saved:"
   echo "$LOG_LINE"
else 
   echo "Session already logged."
fi
# Cleanup: Remove temporary session file
rm session.tmp
