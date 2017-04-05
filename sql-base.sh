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
	vi $SQL_PATH
}

delete_verb(){
	echo "delete from EVA_VERB_LOC where id =$1;
delete from EVA_VERB where id =$1;"
}
update_pd_config(){
	echo "update EVA_PROCESS_DESCRIPTOR set (CONFIG_PROCESS_ID)= ($1) where id = $2"
}


sql_tag(){
	FILE_CONTENT=$(cat ./sql/add-tag.sql)
	echo "$(eval "echo \"$FILE_CONTENT\"")"
}

generate_tag_sql(){
	TAG_NAMES=$1
	DISPLAY_NAMES=$2

	TAGSET_ID=${TAG_NAMES[0]}
	CHILDREN=${#TAG_NAMES[@]}
	TAG_NAME=${TAG_NAMES[0]}
	PARENT_TAG=NULL
	PARENT_TAG_ENV_ID=NULL
	PARENT_TAG_RELEASE_ID=NULL
	PREVIOUS_TAG=NULL
	PREVIOUS_TAG_ENV_ID=NULL
	PREVIOUS_TAG_RELEASE_ID=NULL
	LEFT_VAL=0
	RIGHT_VAL=`expr $CHILDREN \* 2 + 1`
	DEPTH_VAL=0
	DISPLAY_ORDER='1'
	DISPLAY_NAME=${DISPLAY_NAMES[0]}

	TAG_BREAKER=$'\n\n''------------------NEW TAG----------------'$'\n'
	TAG=$(sql_tag)
	SQL=$SQL$TAG_BREAKER$TAG

	LEFT_VAL=-1
	RIGHT_VAL=0
	COUNTER=1
	while [  $COUNTER -lt $CHILDREN ]; do
		if [ $COUNTER -gt 1 ]; then
			PREVIOUS_TAG=@TAG.$TAG_NAME
			PREVIOUS_TAG_ENV_ID=@ENV.Dflt
			PREVIOUS_TAG_RELEASE_ID=@RELEASE.ID
		fi
		TAG_NAME=${TAG_NAMES[$COUNTER]}
		PARENT_TAG=@TAG.${TAG_NAMES[0]}
		PARENT_TAG_ENV_ID=@ENV.Dflt
		PARENT_TAG_RELEASE_ID=@RELEASE.ID
		let LEFT_VAL=LEFT_VAL+2
		let RIGHT_VAL=RIGHT_VAL+2
		DEPTH_VAL=1
		DISPLAY_ORDER=NULL
		DISPLAY_NAME=${DISPLAY_NAMES[0]}
		TAG_NAME=${TAG_NAMES[$COUNTER]}
		DISPLAY_NAME=${DISPLAY_NAMES[$COUNTER]}
		TAG=$(sql_tag)
		SQL=$SQL$TAG_BREAKER$TAG

		let COUNTER=COUNTER+1
	done
	echo "$SQL"
}
