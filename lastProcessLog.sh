#!/bin/bash


if [ -z "$1" ] 
then
	TAIL=1
else
	TAIL=$1
fi
last_log_path(){

	FILE_NAME=$(ls $ADPROCESSLOGS -ltr | grep processLog | tail -$1 | head -1 | rev | cut -d " " -f1 | rev)

	FULL_PATH=$ADPROCESSLOGS/$FILE_NAME
	echo $FULL_PATH
}

echo $(last_log_path $TAIL)
