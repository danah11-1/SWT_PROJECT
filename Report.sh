#!/bin/bash
File="logs/session_log.txt"
if [ ! -f "$File" ]; then
  echo "NO session log found"
  exit 1
fi


Total_Session=$(wc -l < "$File")
echo "Total Session: $Total_Session"


Total_Duration=0
Longest_Session=0
Session_Count=0

echo -e "\nSessions Longer then 45 minutes:"
while read -r line; do
  Min=$(echo "$line" | grep -oP '\d+(?=h)')
  Sec=$(echo "$line" | grep -oP '\d+(?=m)' | head -1)
  
  echo "Min: $Min, Sec: $Sec"

  if [ -n "$Min" ] && [ -n "$Sec" ]; then
     Session_Seconds=$((Min * 60 + Sec ))
     Total_Duration=$((Total_Duration + Session_Seconds))
     Session_Count=$((Session_Count + 1))

     if [ "$Session_Seconds" -gt "$Longest_Session" ]; then
        Longest_Session=$Session_Seconds
     fi  

     if [ "$Session_Seconds" -ge 2700 ]; then
        echo "$line"
     fi
  fi  
done < "$File"


Total_Hours=$((Total_Duration / 3600))
Total_Minutes=$(((Total_Duration % 3600) / 60))


if [ "$Session_Count" -gt 0 ]; then 
   Average_Duration=$((Total_Duration / Session_Count))
   Average_Hours=$((Average_Duration / 3600))
   Average_Minutes=$(((Average_Duration % 3600) / 60))
else
   Average_Hours=0
   Average_Minutes=0
fi


 #Display 
 echo -e "\nTotal time: $Total_Hours h $Total_Minutes m"
 echo "Longest session: $((Longest_Session / 60))m $((Longest_Session % 60))s"
 echo "Average session: $Average_Hours h $Average_Minutes m"















   
 
