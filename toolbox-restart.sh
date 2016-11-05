#!/bin/sh

kill -9 $(ps -ef | grep java | grep ../lib/Toolbox.jar | awk '{print $2}')

./ccadmin.sh toolbox
