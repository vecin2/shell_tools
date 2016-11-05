#!/bin/sh

prj
./ccadmin.sh stop-all-appservers
sleep 2s
./ccadmin.sh start-all-appservers

cd -
