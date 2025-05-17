#!/bin/bash
Current_Branch=$(git branch --show-current)
git add logs/session_log.txt
git commit -m "update the session: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin "$Current_Branch"
