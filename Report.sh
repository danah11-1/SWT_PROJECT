#!/bin/bash

File="logs/session_log.txt"

if [ ! -f "$File" ]; then
    echo "NO session log found"
    exit 1
fi

Total_Session=$(wc -l < "$File")
echo "Total Sessions: $Total_Session"

Total_Duration=0
Longest_Session=0
Session_Count=0
Long_Sessions=""
All_Sessions=""

while read -r line; do
    # Extract hours and minutes with fallback to 0
    Hours=$(echo "$line" | grep -oP '\d+(?=h)')
    Minutes=$(echo "$line" | grep -oP '\d+(?=m)')

    Hours=${Hours:-0}
    Minutes=${Minutes:-0}

    # Convert to seconds
    Session_Seconds=$((Hours * 3600 + Minutes * 60))

    if [ "$Session_Seconds" -gt 0 ]; then
        Total_Duration=$((Total_Duration + Session_Seconds))
        Session_Count=$((Session_Count + 1))

        if [ "$Session_Seconds" -gt "$Longest_Session" ]; then
            Longest_Session=$Session_Seconds
        fi

        if [ "$Session_Seconds" -ge 2700 ]; then
            Long_Sessions+="$line\n"
        fi
    fi
done < "$File"

echo -e "\nSessions Longer than 45 minutes:"
echo -e "$Long_Sessions"


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

echo -e "\nTotal time: $Total_Hours h $Total_Minutes m"
echo "Longest session: $((Longest_Session / 60))m $((Longest_Session % 60))s"
echo "Average session: $Average_Hours h $Average_Minutes m"

 
