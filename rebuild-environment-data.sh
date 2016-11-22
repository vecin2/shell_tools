#!/bin/sh

ENV_NAME=localhost
CONTAINER_NAME=localhost
CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop/
$CORE_HOME/bin/ccadmin.sh stop-all-appservers -Denvironment.name=$ENV_NAME -Dmachine.name=localhost


#rebuild database
$CORE_HOME/bin/ccadmin.sh rebuild-database -Denvironment.name=$ENV_NAME -Dmachine.name=localhost
$CORE_HOME/bin/ccadmin.sh load-workflows -Denvironment.name=$ENV_NAME -Dmachine.name=localhost

#importing data expect kmconfig because it is broken
$CORE_HOME/bin/ccadmin.sh import-data -Denvironment.name=$ENV_NAME -Dmachine.name=localhost -Dcontainer.name=$CONTAINER_NAME -DimportLocation=$CORE_HOME/project/resources/migration/Content.jar
#$CORE_HOME/bin/ccadmin.sh import-data -Denvironment.name=$ENV_NAME -Dmachine.name=localhost -Dcontainer.name=$CONTAINER_NAME -DimportLocation=$CORE_HOME/project/resources/migration/KMConfig.jar
$CORE_HOME/bin/ccadmin.sh import-data -Denvironment.name=$ENV_NAME -Dmachine.name=localhost -Dcontainer.name=$CONTAINER_NAME -DimportLocation=$CORE_HOME/project/resources/migration/Rules.jar
$CORE_HOME/bin/ccadmin.sh import-data -Denvironment.name=$ENV_NAME -Dmachine.name=localhost -Dcontainer.name=$CONTAINER_NAME -DimportLocation=$CORE_HOME/project/resources/migration/ReleaseMigration.jar


