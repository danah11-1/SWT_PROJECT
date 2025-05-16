#!/bin/bash
File="logs/session_log.txt"
if[ ! -f "$File" ]; then
 echo "NO session log found"
 exit 1
fi


Total_Session=$(wc -l < "File")
echo "Total Session: $Total_Session"


Total_Duration=0
Longest_Session=0
Session_Count=0

echo -e "\nSessions Longer then 45 minutes:"
while read -r line; do
  Min=$(echo "$line" | grep -op '\d+(?=د)')
  Sec=$(echo "$line" | grep -op '\d+(?=ث)' | head -1)

  if [ -n "$Min" ] && [ -n "$Sec" ]; then
    Session_Seconds=$((Min * 60 + Sec))
    Total_Duration=$((Total_Duration + Session_Seconds))
    Session_Count=$((Session_Count + 1))

    if [ "$Session_Seconds" -gt "$Longest_Session" ]; then
      Longest_Session=$Session_Seconds
    if  

    if [ "$Min" -ge 45 ]; then
      echo "$line"
    fi
  fi  
done < "$File"

   
















   
 
