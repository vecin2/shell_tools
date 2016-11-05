#!/bin/sh
./ccadmin.sh start-all-appservers

cd ../../WebSelfService/trunk/bin/
./ccadmin.sh start-all-appservers

cd -
