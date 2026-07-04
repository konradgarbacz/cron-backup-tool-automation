#!/bin/bash

# Setup note: created ~/Documents with test files (touch file{1..5}.txt)
# and ~/cron-backup-tool with: backup.sh, backups/, logs/backup.log

# Generate a timestamp (format: YYYY-MM-DD_HH-MM-SS) used for the archive name and log entries
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Directory to be backed up
DIR_TO_BACKUP="$HOME/Documents"

# Directory where backup archives will be stored
DIR_FOR_BACKUP="$HOME/cron-backup-tool/backups"

# Full path of the backup archive, includes the timestamp, saved as .tar.gz
BACKUP_FILE="$DIR_FOR_BACKUP/backup_$TIMESTAMP.tar.gz"

# Path to the log file where backup results will be recorded
LOG_INFO_FILE="$HOME/cron-backup-tool/logs/backup.log"

# Number of days to keep backups; anything older will be deleted
RETENTION_DAYS=7


# Create a compressed (.tar.gz) archive of the source directory
tar -czf "$BACKUP_FILE" "$DIR_TO_BACKUP"

# Check the exit code of the last command (tar): 0 = success, anything else = failure
if [ $? -eq 0 ]; then
    # Append a success message with timestamp and file path to the log
    echo "[$TIMESTAMP] Backup created successfully: $BACKUP_FILE" >> "$LOG_INFO_FILE"
else
    # Append a failure message with timestamp to the log
    echo "[$TIMESTAMP] Backup failed!" >> "$LOG_INFO_FILE"
fi

# Find and delete backup archives older than RETENTION_DAYS days (rotation)
find "$DIR_FOR_BACKUP" -name "backup_*.tar.gz" -type f -mtime +$RETENTION_DAYS -exec rm {} \;