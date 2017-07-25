#!/bin/sh
#read -e -p 

. ./configuration.sh

create_sql_module(){
	SQL_MODULE=$1
	REVISION=$2
	SQL=$3
	FILE_NAME=$4
	echo   "Creating sql module with sql: $SQL"
	SQL_PATH=$CORE_HOME/modules/$SQL_MODULE
	mkdir -p $SQL_PATH

	echo PROJECT \$Revision: $REVISION \$ > $SQL_PATH/update.sequence 
	if [ -z "$FILE_NAME" ]; then
		FILE_NAME=tableData.sql
	fi
	echo   "$SQL" > $SQL_PATH/$FILE_NAME
	#vi $SQL_PATH/$FILE_NAME
	echo $SQL_PATH/$FILE_NAME
}

delete_verb(){
	echo "delete from EVA_VERB_LOC where id =$1;
	delete from EVA_VERB where id =$1;"
}
update_pd_config(){
	echo "update EVA_PROCESS_DESCRIPTOR set (CONFIG_PROCESS_ID)= ($1) where id = $2"
}


parse_template(){
	if [ -f ./sql/$1 ]; then
		FILE_CONTENT=$(cat ./sql/$1)
		echo "$(eval "echo \"$FILE_CONTENT\"")"
	else
		echo "Template ./sql/$1 does not exist"
		return 1
	fi
}
