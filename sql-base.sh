#!/bin/sh
#read -e -p 

. ./configuration.sh

create_sql_module(){
	SQL_MODULE=$1
	REVISION=$2
	SQL=$3
	echo   "Creating sql module with sql: $SQL"
	SQL_PATH=$CORE_HOME/modules/$SQL_MODULE
	mkdir -p $SQL_PATH

	echo PROJECT \$Revision: $REVISION \$ > $SQL_PATH/update.sequence 
	echo   "$SQL" > $SQL_PATH/tableData.sql
	vi $SQL_PATH/tableData.sql
}

delete_verb(){
	echo "delete from EVA_VERB_LOC where id =$1;
	delete from EVA_VERB where id =$1;"
}
update_pd_config(){
	echo "update EVA_PROCESS_DESCRIPTOR set (CONFIG_PROCESS_ID)= ($1) where id = $2"
}


