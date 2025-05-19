#!/bin/bash

#git the name of current git branch
Current_Branch=$(git branch --show-current)
#stage the session log file for commit
git add logs/session_log.txt
#commit the changes 
git commit -m "update the session: $(date '+%Y-%m-%d %H:%M:%S')"
#push the commit 
git push origin "$Current_Branch"
