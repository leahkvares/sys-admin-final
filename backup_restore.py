#!/usr/bin/python3
import os

# Ensure the directories /backup and /var/tmp/restore exist
# If they don't, create them
if not os.path.exists('/backup'):
    os.system('mkdir /backup')
if not os.path.exists('/var/tmp/restore'):
    os.system('mkdir /var/tmp/restore')

# args: backup_restore.py backup
def backup():
    # Create a unique timestamp
    timestamp = os.popen('date +%Y%m%d%H%M%S').read().strip()
    # Create a compressed tar file
    # Back up the /home/student directory into /backup
    os.system('tar -czf /backup/student-' + timestamp + '.tar.gz /home/student')
    # Log the operation to Syslog
    os.system('logger Backup created: student-' + timestamp)
    # Success message
    print('Backup created: student-' + timestamp)

# args: backup_restore.py restore
# extract the latest backup from /backup into /var/tmp/restore
#  create /var/tmp/restore if it doesn't exist and logs the restore opera;on to Syslog
# success message
def restore():
    # Create /var/tmp/restore if it doesn't exist
    if not os.path.exists('/var/tmp/restore'):
        os.system('mkdir /var/tmp/restore')
    # Extract the latest backup
    latest_backup = os.popen('ls -t /backup | head -n 1').read().strip()
    os.system('tar -xzf /backup/' + latest_backup + ' -C /var/tmp/restore')
    # Log the restore operation to Syslog
    os.system('logger Backup restored: ' + latest_backup)
    # Success message
    print('Backup restored: ' + latest_backup)