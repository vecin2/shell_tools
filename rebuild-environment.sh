#!/bin/sh

ENV_NAME=LOCAL_AD
CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop/
$CORE_HOME/bin/ccadmin.sh recreate-environment -Denvironment.name=$ENV_NAME 

./rebuild-environment-data.sh

