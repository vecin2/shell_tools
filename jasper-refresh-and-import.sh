#!/bin/bash

echo updating from  $2
./jasper-refresh-repo.sh $1

if [ $# -gt 1 ]; then
	echo updating from  $2
	./jasper-refresh-repo.sh $2
fi


./ccadmin.sh jasper-import

if [ $? -eq 0 ]; then
	./ad-restart-session.sh
fi
