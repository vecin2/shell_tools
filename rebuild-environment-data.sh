#!/bin/sh

. ./configuration.sh

ENV_NAME=local
MACHINE_NAME=localhost
CONTAINER_NAME=container_ad_1
$CORE_HOME/bin/ccadmin.sh stop-all-appservers -Denvironment.name=$ENV_NAME -Dmachine.name=$MACHINE_NAME


#rebuild database
$CORE_HOME/bin/ccadmin.sh rebuild-database -Denvironment.name=$ENV_NAME -Dmachine.name=$MACHINE_NAME
$CORE_HOME/bin/ccadmin.sh load-workflows -Denvironment.name=$ENV_NAME -Dmachine.name=$MACHINE_NAME

#importing data 
./import-data.sh

