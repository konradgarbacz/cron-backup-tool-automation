Cron Backup Tool
#######
A simple bash-based backup automation tool with rotation, scheduled via cron.


Overview
#######
This project automatically backs up a specified directory into a timestamped .tar.gz archive, logs the result, and removes backups older than a configurable retention period. It installs itself into the system crontab so backups run on a schedule without manual intervention.
Features

📦 Creates compressed .tar.gz archives with a timestamp in the filename
📝 Logs every backup attempt (success or failure) with a timestamp
🗑️ Automatically deletes backups older than a configurable number of days
⏰ One-command installation into cron — no manual crontab editing required
🔄 Safe cron installation — appends to existing crontab entries instead of overwriting them

Project Structure
cron-backup-tool/
├── backup.sh           # Main backup script
├── install-cron.sh     # Installs the scheduled cron job
├── backups/            # Generated backup archives (.tar.gz)
└── logs/
    └── backup.log       # Log of backup operations
    
Requirements
#######
Bash
tar
cron (on Ubuntu/Debian: sudo apt install cron)

Installation
#######
Clone the repository:
bashgit clone https://github.com/konradgarbacz/cron-backup-tool.git
cd cron-backup-tool
Make the scripts executable:
chmod +x backup.sh install-cron.sh
Install the cron job:
bash install-cron.sh
Verify the cron job was added:
bashcrontab -l


How It Works
######
backup.sh generates a timestamp and creates a compressed archive of the source directory using tar.
It checks the exit code of the tar command to determine success or failure, and logs the result.
It searches for old backup archives (older than RETENTION_DAYS) using find and deletes them.
install-cron.sh builds a cron schedule line and appends it to the user's crontab without overwriting existing entries.

