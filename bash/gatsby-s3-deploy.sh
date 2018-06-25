#!/bin/sh
: '
    This script builds and deploys gatsby project onto amazon s3.
    It will also make a backup of current production bucket into a backup bucket.
    
    Prerequisites:
        * awscli installed and configured with appropriate credentials(run "awscli configure" if you haven't)
        * Buckets created and configured with appropriate permissions corresponding to user used in configuration.
        * Production and backup constants set.
    
    Usage:
        * Run the script in the root directory of the gatsby project.
    
    WARNING: This script will delete everything in the ./public directory as well as old s3 objects not present in public folder
             after the build(read more about aws s3 sync's --delete option if unsure what this means).
             
'
        
BACKUP_BUCKET="s3://"
PRODUCTION_BUCKET="s3://"

echo "ARE YOU SURE YOU WANT TO DEPLOY?!(y/n) \n(this will remove contents of public/ in current dir)"
read answer

if [ "$answer" = "y" ] || [ "$answer" = "Y" ] ; then
    echo "Build started..."
    # clean out public directory
    rm -r public/*
    gatsby build
    echo "\n*** Deployment started... ***\n"
    # sync current production to the backup bucket
    aws s3 sync $PRODUCTION_BUCKET $BACKUP_BUCKET --delete
    echo "\n***Backup updated***\n"
    # sync fresh build to production bucket
    aws s3 sync public/ $PRODUCTION_BUCKET --delete --acl public-read
    echo "\n***Production updated***"
else 
    echo "Exiting..."
fi
