#!/bin/bash


if [ -z "$1" ] 
then
	TAIL=1
else
	TAIL=$1
fi
last_applog_path(){

	FILE_NAME=$(ls $ADAPPLOGS -ltr | grep application_ | tail -$1 | head -1 | rev | cut -d " " -f1 | rev)

	FULL_PATH=$ADAPPLOGS/$FILE_NAME
	echo $FULL_PATH
}

echo $(last_applog_path $TAIL)
