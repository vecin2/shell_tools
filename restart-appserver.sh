#!/bin/sh

prj
./ccadmin.sh stop-appserver
sleep 2s
./ccadmin.sh start-appserver

cd -
