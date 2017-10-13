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
	templates_path="./sql/sql-templates/"
	if [ -f $templates_path$1 ]; then
		file_content=$(cat $templates_path$1)
		last_parsed_template=$(eval "echo \"$file_content\"")
	else
		echo "Template $templates_path$1 does not exist"
		return 1
	fi
}
empty_parse_buffer(){
	echo "$LAST_PARSED_TEMPLATE"
	LAST_PARSED_TEMPLATE=""
}
