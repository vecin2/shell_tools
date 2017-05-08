#!/bin/bash


if [ -z "$1" ] 
then
	TAIL=1
else
	TAIL=$1
fi
last_log_path(){

	SESSION_LOGS_PATH=../logs/localhost-container_ad_1/cre/session/process/
	FILE_NAME=$(ls $SESSION_LOGS_PATH -ltr | grep processLog | tail -$1 | head -1 | rev | cut -d " " -f1 | rev)

	FULL_PATH=$SESSION_LOGS_PATH/$FILE_NAME
	echo $FULL_PATH
}

echo $(last_log_path $TAIL)
