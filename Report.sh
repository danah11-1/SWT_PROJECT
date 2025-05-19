#!/bin/bash

# Define the file containing session logs
File="logs/session_log.txt"

# Check if the log file exists
if [ ! -f "$File" ]; then
    echo "NO session log found"
    exit 1
fi

# Count the total number of sessions
Total_Session=$(wc -l < "$File")
echo "Total Sessions: $Total_Session"

# Initialize variables for total duration, longest session, and session counts
Total_Duration=0
Longest_Session=0
Session_Count=0
Long_Sessions=""  # Store sessions longer than 45 minutes
All_Sessions=""   # Store all session details (not used in the current logic)

# Read each line from the session log file
while read -r line; do
    # Extract hours and minutes from the line using regex
    Hours=$(echo "$line" | grep -oP '\d+(?=h)')
    Minutes=$(echo "$line" | grep -oP '\d+(?=m)')

    # Set default values to 0 if not found
    Hours=${Hours:-0}
    Minutes=${Minutes:-0}

    # Convert hours and minutes to total seconds
    Session_Seconds=$((Hours * 3600 + Minutes * 60))

    # Only process sessions with positive duration
    if [ "$Session_Seconds" -gt 0 ]; then
        Total_Duration=$((Total_Duration + Session_Seconds))  # Accumulate total duration
        Session_Count=$((Session_Count + 1))                  # Increment session count

        # Check if this is the longest session
        if [ "$Session_Seconds" -gt "$Longest_Session" ]; then
            Longest_Session=$Session_Seconds
        fi

        # Check if the session is longer than 45 minutes (2700 seconds)
        if [ "$Session_Seconds" -ge 2700 ]; then
            Long_Sessions+="$line\n"  # Append to long sessions
        fi
    fi
done < "$File"

# Print sessions longer than 45 minutes
echo -e "\nSessions Longer than 45 minutes:"
echo -e "$Long_Sessions"

# Calculate total hours and minutes from total duration
Total_Hours=$((Total_Duration / 3600))
Total_Minutes=$(((Total_Duration % 3600) / 60))

# Calculate average session duration if there are any sessions
if [ "$Session_Count" -gt 0 ]; then 
    Average_Duration=$((Total_Duration / Session_Count))
    Average_Hours=$((Average_Duration / 3600))
    Average_Minutes=$(((Average_Duration % 3600) / 60))
else
    Average_Hours=0
    Average_Minutes=0
fi

# Print total time, longest session, and average session duration
echo -e "\nTotal time: $Total_Hours h $Total_Minutes m"
echo "Longest session: $((Longest_Session / 60))m $((Longest_Session % 60))s"
echo "Average session: $Average_Hours h $Average_Minutes m"
 
