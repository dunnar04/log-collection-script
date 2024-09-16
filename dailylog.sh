#!/bin/bash

SERVERS=("10.1.0.9" "10.1.0.11" "10.1.0.13" "10.1.0.14")
LOG_FILE="var/log/syslog"
USER="oadetola"
LOG_DIR="/home/oadetola/logs"
DATE=$(date +"%Y-%m-%d")

#create a directory for the log
LOG_STORE_DIR="$LOG_DIR/$DATE"
mkdir -p "$LOG_STORE_DIR"

collect_logs() {
	for SERVER in "${SERVERS[@]}"; do
		echo "Collecting logs from $SERVER."
		scp "$USER@$SERVER:$LOG_FILE" "$LOG_STORE_DIR/${SERVER}_syslog_$DATE.log"
		if [[ $? -eq 0 ]]; then
			echo "Logs succesfully collected from $SERVER."
		else
			echo "Failed to collect log from $SERVER."
		fi
	done
}

# Run log function
collect_logs

# End Script
echo "Log collection complete. Logs are stored in $LOG_STORE_DIR."

