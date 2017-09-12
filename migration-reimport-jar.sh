#!/bin/bash

SHELL_DIR=$(pwd)
cd ../migration/
svn up

echo "Changing directory back to $SHELL_DIR"
cd $SHELL_DIR 
jar_location=$AD/shell_tools/$1
RESULT=$(./ccadmin.sh import-data -DimportLocation=$jar_location)
SESSION_LINE=$(echo $RESULT | grep "Please check the session and migration logs for session '")
SESSION_ID=$(echo $SESSION_LINE |  awk '{for(i=1;i<=NF;i++) if ($i=="for" && $(i+1)=="session") print $(i+2)}' | sed "s/'//g")

LOG=$ADPROCESSLOGS/../migration/migration_$SESSION_ID.log

echo log path is $LOG

if [ "$SESSION_ID" ]; then
	vi $LOG
fi
