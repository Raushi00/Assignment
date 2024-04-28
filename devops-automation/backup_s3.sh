#!/bin/bash

S3_BUCKET="bucket-name"
BACKUP_DIR="/home/raushan/Desktop/EKS/bkp/28-apr"

if [ -d "$BACKUP_DIR" ]; then
    echo "Directory already exists. Skipping creation."
else
    mkdir -p "$BACKUP_DIR"
fi

aws s3 sync "s3://$S3_BUCKET" "$BACKUP_DIR"

echo "Backup completed to: $BACKUP_DIR"


