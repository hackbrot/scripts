#!/bin/bash

# Editable Variables

server_path=/path/to/your/mcserver  # for example /var/lib/pufferpanel/servers/myserver

output_path=/mnt/mynas/backups/minecraft/myserver # you need to mount the nas to your filesystem (you can use fstab for it)

log_path=/var/log/mcbackup/backup.log # where logs should be stored

nas_ip=0.0.0.0 # change to the ip of your NAS

# --- START --- #

start=`date +%s.%N`

# test connection to NAS
ping $nas_ip -c 3 2>&1 | tee $log_path

if [ $? -eq 0 ]
then

	echo "Start Backup of Minecraft Server"

	# copy server folder to NAS folder and overwrites it 
	cp -v -r -f $server_path $output_path 2>&1 | tee $log_path

	end=`date +%s`

	if [ $? -eq 0 ]
	then
		date_time=$(date +'%H:%M:%S')
		runtime=$((end-start))
		echo "BACKUP FINISHED at $date_time. Took $runtime"
	else
		echo "BACKUP FAILED! There was an error executing cp. Exit code $?"
	fi

else
	echo "BACKUP FAILED! NAS couldn't be reached via the IP $nas_ip"
fi

# --- END --- #
