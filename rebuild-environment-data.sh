#!/bin/sh

ENV_NAME=LOCAL_AD
CONTAINER_NAME=localhost
CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop/
$CORE_HOME/bin/ccadmin.sh stop-all-appservers -Denvironment.name=$ENV_NAME -Dmachine.name=localhost


#rebuild database
$CORE_HOME/bin/ccadmin.sh rebuild-database -Denvironment.name=$ENV_NAME -Dmachine.name=localhost
$CORE_HOME/bin/ccadmin.sh load-workflows -Denvironment.name=$ENV_NAME -Dmachine.name=localhost

#importing data 
./import-data.sh

