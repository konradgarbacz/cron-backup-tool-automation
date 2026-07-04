# Cron Backup Tool

A simple bash-based backup automation tool with rotation, scheduled via cron.

## Overview

This project automatically backs up a specified directory into a timestamped `.tar.gz` archive, logs the result, and removes backups older than a configurable retention period. It installs itself into the system crontab so backups run on a schedule without manual intervention.

## Features

- 📦 Creates compressed `.tar.gz` archives with a timestamp in the filename
- 📝 Logs every backup attempt (success or failure) with a timestamp
- 🗑️ Automatically deletes backups older than a configurable number of days
- ⏰ One-command installation into cron — no manual crontab editing required
- 🔄 Safe cron installation — appends to existing crontab entries instead of overwriting them

## Project Structure

```
cron-backup-tool/
├── backup.sh           # Main backup script
├── install-cron.sh     # Installs the scheduled cron job
├── backups/            # Generated backup archives (.tar.gz)
└── logs/
    └── backup.log      # Log of backup operations
```

## Requirements

- Bash
- `tar`
- `cron` (on Ubuntu/Debian: `sudo apt install cron`)

## Installation

Clone the repository:

```bash
git clone https://github.com/konradgarbacz/cron-backup-tool.git
cd cron-backup-tool
```

Make the scripts executable:

```bash
chmod +x backup.sh install-cron.sh
```

Install the cron job:

```bash
./install-cron.sh
```

Verify the cron job was added:

```bash
crontab -l
```

## Configuration

Edit the variables at the top of `backup.sh`:

| Variable | Description | Default |
|---|---|---|
| `DIR_TO_BACKUP` | Directory to back up | `$HOME/Documents` |
| `DIR_FOR_BACKUP` | Directory where backup archives are stored | `$HOME/cron-backup-tool/backups` |
| `LOG_INFO_FILE` | Path to the log file | `$HOME/cron-backup-tool/logs/backup.log` |
| `RETENTION_DAYS` | Number of days to keep backups before deletion | `7` |

Edit the schedule in `install-cron.sh`:

| Variable | Description | Default |
|---|---|---|
| `CRON_SCHEDULE` | Cron schedule expression | `0 6 * * *` (daily at 6:00 AM) |

## Manual Usage

You can also run a backup manually at any time, without waiting for cron:

```bash
./backup.sh
```

## Logs

Every run appends a line to `logs/backup.log`, e.g.:

```
[2026-07-04_16-24-19] Backup created successfully: /home/user/cron-backup-tool/backups/backup_2026-07-04_16-24-19.tar.gz
```

## How It Works

1. `backup.sh` generates a timestamp and creates a compressed archive of the source directory using `tar`.
2. It checks the exit code of the `tar` command to determine success or failure, and logs the result.
3. It searches for old backup archives (older than `RETENTION_DAYS`) using `find` and deletes them.
4. `install-cron.sh` builds a cron schedule line and appends it to the user's crontab without overwriting existing entries.
