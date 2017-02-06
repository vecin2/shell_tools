#!/bin/sh
#. config.sh

SQL_MODULE=PruCaseHandling/sqlScripts/oracle/updates/Pru_R3_0_1/RewiringCreateCaseWizardWrapper
REVISION=11169
REPOSITORY_PATH=PruCaseHandling.Implementation.Case.Processes.CreateCaseWizardWrapper


CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop
SQL_PATH=$CORE_HOME/modules/$SQL_MODULE

mkdir -p $SQL_PATH
SQL="update EVA_PROCESS_DESCRIPTOR 
set (REPOSITORY_PATH) = ('$REPOSITORY_PATH')
where ID =@PD.CreateCaseWizard ;"

echo PROJECT \$Revision: $REVISION \$ > $SQL_PATH/update.sequence 
echo  $SQL > $SQL_PATH/tableData.sql
