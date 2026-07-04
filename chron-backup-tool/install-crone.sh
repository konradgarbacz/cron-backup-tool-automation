#!/bin/bash

# Path to the backup script that will be run by cron
SCRIPT_PATH="$HOME/cron-backup-tool/backup.sh"

# Cron schedule expression: run daily at 6:00 AM (minute=0, hour=6)
CRON_SCHEDULE="0 6 * * *"

# Combine the schedule and script path into a single crontab line
CRON_LINE="$CRON_SCHEDULE $SCRIPT_PATH"

# Append the new line to the existing crontab (without overwriting current jobs):
# 1. crontab -l   -> list current cron jobs
# 2. echo "..."   -> add the new job line
# 3. crontab -    -> save the combined result as the new crontab
(crontab -l ; echo "$CRON_LINE") | crontab -