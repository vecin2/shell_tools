#!/bin/sh
#read -e -p 


create_sql_module(){
	SQL_MODULE=$1
	REVISION=$2
	SQL=$3
echo   "Creating sql module with sql: $SQL"
	CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop
	SQL_PATH=$CORE_HOME/modules/$SQL_MODULE
	mkdir -p $SQL_PATH

	echo PROJECT \$Revision: $REVISION \$ > $SQL_PATH/update.sequence 
	echo   $SQL > $SQL_PATH/tableData.sql
	vi $SQL_PATH
}
