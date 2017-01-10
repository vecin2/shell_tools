#!/bin/sh
#. config.sh
#read -e -p 
SQL_MODULE=PruCaseHandling/sqlScripts/oracle/updates/Pru_R3_0_1/ChaseIllustrationPD
REVISION=11171
PROCESS_DESCRIPTOR_NAME=ChaseIllustration
PROCESS_DESCRIPTOR_DESCRIPTION="It sends the customer a reminder to try to convert the illustration into an application"
REPOSITORY_PATH=PruCaseHandling.Implementation.Illustrations.Actions.ChaseIllustration
TYPE=3

CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop
SQL_PATH=$CORE_HOME/modules/$SQL_MODULE

mkdir -p $SQL_PATH
SQL="INSERT INTO EVA_PROCESS_DESCRIPTOR (ID, ENV_ID, NAME, REPOSITORY_PATH, CONFIG_PROCESS_ID, IS_DELETED, TYPE) VALUES (@PD.$PROCESS_DESCRIPTOR_NAME, @ENV.Dflt, '$PROCESS_DESCRIPTOR_NAME', '$REPOSITORY_PATH', null, 'N', $TYPE);\n
INSERT INTO EVA_PROCESS_DESCRIPTOR_LOC (ID, ENV_ID, LOCALE, DISPLAY_NAME, DESCRIPTION) VALUES (@PD.$PROCESS_DESCRIPTOR_NAME, @ENV.Dflt, 'en-GB', '$PROCESS_DESCRIPTOR_NAME', '$PROCESS_DESCRIPTOR_DESCRIPTION');"

echo PROJECT \$Revision: $REVISION \$ > $SQL_PATH/update.sequence 
echo  $SQL > $SQL_PATH/tableData.sql
