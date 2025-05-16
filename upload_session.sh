#!/bin/bash

git add logs/session.log.txt
git commit -m "update the session: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main
