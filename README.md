# Dockup

Docker image to backup your Docker container volumes. Why the name? Docker + Backup = Dockup!

# Usage

Using `/config/env.sh` file that outputs required env vars, backups up the target folder to S3 on demand or via cron schedule. The contents of `env.sh` being:

```
#!/bin/bash

export AWS_ACCESS_KEY_ID=[ACCESS_KEY]
export AWS_SECRET_ACCESS_KEY=[ACCESS_KEY_SECRET]
export AWS_DEFAULT_REGION=us-east-1
export BACKUP_NAME=[BACKUP_FILE_NAME]
export PATHS_TO_BACKUP=/backup
export S3_BUCKET_NAME=[S3_BUCKET_NAME]
export RESTORE=false
export CRON_TIME=0\ 2\ *\ *\ * # every night at 2am
```

`dockup` will use your AWS credentials to create a new bucket with name as per the environment variable `S3_BUCKET_NAME`, or if not defined. The paths in `PATHS_TO_BACKUP` will be tarballed, gzipped, time-stamped and uploaded to the S3 bucket.

## Container Requirements

### Volumes

`/backup` - mount the folder to be backed up here
`/config/env.sh` - environment variables to control backups

### Environment Variables

`LOGSPOUT:ignore` - tell Logspout to ignore these logs

## Restore

To restore your data simply set the `RESTORE` environment variable to `true` - this will restore the latest backup from S3 to your volume.
