

if [ -z "$1" ] 
then
  TAIL=1
else
  TAIL=$1
fi

#!/bin/sh
SESSION_LOGS_PATH=../logs/localhost-container_ad_1/cre/session/process/
FILE_NAME=$(ls $SESSION_LOGS_PATH -ltr | grep processLog | tail -$TAIL | head -1 | rev | cut -d " " -f1 | rev)

FULL_PATH=$SESSION_LOGS_PATH/$FILE_NAME
echo $FULL_PATH

vi $FULL_PATH

