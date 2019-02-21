#!/bin/bash

# Get env vars
. /config/env.sh

if [[ "$RESTORE" == "true" ]]; then
  ./restore.sh
#else
  # enable this to run a backup on container start
  #./backup.sh
fi

echo "Setting up Backups..."
echo "Backing up files in: $PATHS_TO_BACKUP to: s3://$S3_BUCKET_NAME/$BACKUP_NAME"

if [ -n "$CRON_TIME" ]; then
  echo "Registering backup cronjob"
  echo "${CRON_TIME} /backup.sh >> /dockup.log 2>&1" > /crontab.conf
  crontab  /crontab.conf
  echo "=> Running dockup backups as a cronjob for ${CRON_TIME}"
  exec cron -f
else
  echo "Running a one off backup"
  ./backup.sh
fi