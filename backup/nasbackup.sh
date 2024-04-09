#!/bin/bash

# Editable Variables

log_path=/var/log/nasbackup/backup.log # where logs should be created

config_file=-c /path/to/your/snapraid/config.conf # dependant on your setup, change this to the location of your config

has_docker=false # change to true to stop docker containers while the script is running. 

# --- START --- #

echo "Start Backup Stack"

# Stop Docker Containers

if [ $has_docker -eq true ]
then
    echo "Stopping Docker Containers..."
    docker stop $(docker ps -a -q ) 0>> $log_path # If docker containers are running, stop them
fi

# Execute Scrub

echo "Executing SnapRAID Scrub..."

snapraid scrub $config_file 0>> $log_path

if [ $? -eq 0 ]
then
    echo "SnapRAID Scrub successful"
else
    echo "SnapRAID Scrub failed with exit code $?"
fi

# Check Diff...

echo "Check for differences..."

snapraid diff $config_file 2>> $log_path

case $? in
    0) echo "No Differences found. No Sync necessary.";;
    1) echo "SnapRAID Diff failed with exit code $?";;
    2) echo "Sync necessary. Executing SnapRAID Sync..."

       snapraid sync $config_file 0>> $log_path

       if [ $? -eq 0 ]
       then
           echo "SnapRAID Sync was successful at $(date)"
       else
           echo "SnapRAID Sync failed with exit code $?"
       fi;;
     *) echo "Unknown Error"
esac

# Start Docker Container s

if [ $has_docker -eq true ]
then
    echo "Starting Docker Cointainers..."
    docker start $(docker ps -a -q) 0>> $log_path # start containers 
fi

# --- END --- #

echo "Backup Stack completed!"