#!/bin/bash

SUCCESS=0
RESULT=1
WAIT=6
TRIALS=12
CURRENT=0
while [[ $RESULT -gt $SUCCESS && $CURRENT -lt $TRIALS ]]; do
	wget --spider  http://localhost:8280/SPAdmin
	RESULT=$?
	sleep ${WAIT}s
	let CURRENT=$CURRENT+1
	echo result is $RESULT
done
return $RESULT
