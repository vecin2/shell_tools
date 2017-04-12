#!/bin/sh
. ./configuration.sh

echo Killing session in appserver: $APP_SERVER
kill -9 $(ps -ef | grep java |  grep $APP_SERVER | awk '{print $2}')

