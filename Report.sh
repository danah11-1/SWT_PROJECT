#!/bin/bash

 # Define the path to the session log file
 File="logs/session_log.txt"

 # Check if the log file exists
 if [ ! -f "$File" ]; then
    echo "NO session log found"
    exit 1
 fi

 # Count the total number of sessions
 Total_Session=$(wc -l < "$File")
 echo "Total Session: $Total_Session"

 # Initialize variables to calculate session duration
 Total_Duration=0
 Longest_Session=0
 Session_Count=0

 # Print the header for sessions longer than 45 minutes
 echo -e "\nSessions Longer than 45 minutes:"

 # Read each line from the log file
 while read -r line; do
    # Extract minutes and seconds from the line
    Min=$(echo "$line" | grep -oP '\d+(?=h)')
    Sec=$(echo "$line" | grep -oP '\d+(?=m)' | head -1)
  
   

   # Check if minutes and seconds are present
   if [ -n "$Min" ] && [ -n "$Sec" ]; then
      # Calculate session duration in seconds
      Session_Seconds=$((Min * 60 + Sec ))
      Total_Duration=$((Total_Duration + Session_Seconds))
      Session_Count=$((Session_Count + 1))

      # Update longest session if the current session is longer
      if [ "$Session_Seconds" -gt "$Longest_Session" ]; then
         Longest_Session=$Session_Seconds
      fi  

      # Print sessions longer than 45 minutes (2700 seconds)
      if [ "$Session_Seconds" -ge 2700 ]; then
         echo "$line"
      fi
   fi  
 done < "$File"

 # Calculate total time in hours and minutes
 Total_Hours=$((Total_Duration / 3600))
 Total_Minutes=$(((Total_Duration % 3600) / 60))

 # Calculate average session duration
 if [ "$Session_Count" -gt 0 ]; then 
    Average_Duration=$((Total_Duration / Session_Count))
    Average_Hours=$((Average_Duration / 3600))
    Average_Minutes=$(((Average_Duration % 3600) / 60))
 else
    Average_Hours=0
    Average_Minutes=0
 fi

 # Display the results
 echo -e "\nTotal time: $Total_Hours h $Total_Minutes m"
 echo "Longest session: $((Longest_Session / 60))m $((Longest_Session % 60))s"
 echo "Average session: $Average_Hours h $Average_Minutes m"
