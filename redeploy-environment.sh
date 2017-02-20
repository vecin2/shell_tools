#!/bin/sh

ENV_NAME=LOCAL_AD
CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop/
$CORE_HOME/bin/ccadmin.sh recreate-environment -Denvironment.name=$ENV_NAME 

./stop-all-applications.sh

./redeploy-wss.sh
./redeploy-ad.sh
