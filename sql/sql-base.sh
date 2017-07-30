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


parse_template(){
	TEMPLATES_PATH="./sql/templates/"
	if [ -f $TEMPLATES_PATH$1 ]; then
		FILE_CONTENT=$(cat $TEMPLATES_PATH$1)
		LAST_PARSED_VALUE="$(eval "echo \"$FILE_CONTENT\"")"
		echo $LAST_PARSED_VALUE
	else
		echo "Template $TEMPLATES_PATH$1 does not exist"
		return 1
	fi
}
