#!/bin/bash
File="logs/session_log.txt"
if[ ! -f "$File" ]; then
 echo "NO session log found"
 exit 1
fi

#Total number of sessions
Total_Session=$(wc -l < "File")
echo "Total Session: $Total_Session"

#Total duration in seconds
Total_Duration=0
Longest_
 
