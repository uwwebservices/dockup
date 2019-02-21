#!/bin/bash

# Get env vars
. /config/env.sh

if [[ "$RESTORE" == "true" ]]; then
  ./restore.sh
else
  # enable this to run a backup on container start
  #./backup.sh
fi

if [ -n "$CRON_TIME" ]; then
  echo "${CRON_TIME} /backup.sh >> /dockup.log 2>&1" > /crontab.conf
  crontab  /crontab.conf
  echo "=> Running dockup backups as a cronjob for ${CRON_TIME}"
  exec cron -f
else
  ./backup.sh
fi