#!/bin/bash

. ./configuration.sh 

SPADMIN_URL=$AD_URL/SPAdmin
echo spadmin url is $SPADMIN_URL
is_server_up(){
	wget --spider $SPADMIN_URL
	IS_UP=$?
	if [ $IS_UP -eq 0 ]; then
		return 0
	else
		return 1
	fi
}

pool_server_until_up(){
	SUCCESS=0
	RESULT=1
	WAIT=6
	TRIALS=15
	CURRENT=0
	while [[ $RESULT -gt $SUCCESS && $CURRENT -lt $TRIALS ]]; do
		is_server_up
		RESULT=$?
		sleep ${WAIT}s
		let CURRENT=$CURRENT+1
		echo result is $RESULT
	done
	if [ $RESULT -eq 0 ]; then
		echo server is up
	else
		echo server did not start in time
	fi
	return $RESULT
}

run_app(){
	if is_server_up; then
		echo server is already running
	else
		./start-all-appservers.sh
		sleep 5s
		pool_server_until_up
	fi
	if [ $? -eq 0 ]; then
		chromium-browser $1
	fi
}
