#!/bin/sh
BACKUP_BUCKET="s3://"
PRODUCTION_BUCKET="s3://"

echo "ARE YOU SURE YOU WANT TO DEPLOY?!(y/n) \n(this will remove contents of public/ in current dir)"
read answer

if [ "$answer" = "y" ] || [ "$answer" = "Y" ] ; then
    echo "Build started..."
    rm -r public/*
    gatsby build
    echo "\n*** Deployment started... ***\n"
    aws s3 sync $PRODUCTION_BUCKET $BACKUP_BUCKET --delete
    echo "\n***Backup updated***\n"
    aws s3 sync public/ $PRODUCTION_BUCKET --delete --acl public-read
    echo "\n***Production updated***"
else 
    echo "Exiting..."
fi
