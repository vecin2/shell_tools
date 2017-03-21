#!/bin/sh

ENV_NAME=LOCAL_AD
CONTAINER_NAME=localhost
CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop/


svn up &&
	$CORE_HOME/shell-tools/stop-all-applications.sh && 
	./redeploy-envivornment.sh && 
	$CORE_HOME/bin/ccadmin.sh upgrade-database -Denvironment.name=$ENV_NAME -Dmachine.name=localhost &&
	$CORE_HOME/bin/ccadmin.sh import-data -DimportLocation=\"$CORE_HOME/project/resources/migration/ReleaseMigration.jar -Denvironment.name=$ENV_NAME -Dmachine.name=localhost\"" 




