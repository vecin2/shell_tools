#!/bin/bash


#. ./sql-base.sh

SQL_MODULE=/TEST
REVISION=15368

sql_tag(){
	FILE_CONTENT=$(cat ./sql/add-tag.sql)
	echo "$(eval "echo \"$FILE_CONTENT\"")"
}
item_equal(){
	if [ "${DISPLAY_NAMES[$2]}" == "$1" ]; then
		return 0;
	else
		return 1;
	fi
}
begin_new_level(){
	item_equal "[" $1
}
is_parent(){
	item_equal "[" $COUNTER+1
}
end_level(){
	item_equal "]" $1
}
count_children(){
	let COUNT_CHILD_IND=2+$1
	NUM_CHILDREN=0
	while [ $COUNT_CHILD_IND -lt $ARRAY_LENGTH ]; do
		if end_level $COUNT_CHILD_IND; then
			return $NUM_CHILDREN
		fi
		let NUM_CHILDREN=$NUM_CHILDREN+1
		let COUNT_CHILD_IND=$COUNT_CHILD_IND+1
	done
	return $NUM_CHILDREN
}
number_of_tags(){
	IN_COUNTER=1
	NUM_TAGS=0
	while [ $IN_COUNTER -lt $ARRAY_LENGTH ]; do
		if end_level $IN_COUNTER; then
			let IN_COUNTER=$IN_COUNTER+1
			continue
		elif begin_new_level $IN_COUNTER; then
			let IN_COUNTER=$IN_COUNTER+1
			continue
		fi
		let NUM_TAGS=$NUM_TAGS+1
		let IN_COUNTER=$IN_COUNTER+1
	done
	return $NUM_TAGS
}
print_tag(){
	echo "IS_SYSTEM=$IS_SYSTEM
	TAG_ID=$TAG_ID DISPLAY_NAME=$DISPLAY_NAME TAGSET_ID=$TAGSET_ID DISPLAY_ORDER=$DISPLAY_ORDER
	PARENT_TAG=$PARENT_TAG	PARENT_TAG_ENV_ID=$PARENT_TAG_ENV_ID PARENT_TAG_RELEASE_ID=$PARENT_TAG_RELEASE_ID
	PREVIOUS_TAG=$PREVIOUS_TAG PREVIOUS_TAG_ENV_ID=$PREVIOUS_TAG_ENV_ID PREVIOUS_TAG_RELEASE_ID=$PREVIOUS_TAG_RELEASE_ID
	LEFT_VAL=$LEFT_VAL RIGHT_VAL=$RIGHT_VAL DEPTH_VAL=$DEPTH_VAL
	EXPAND_DIRECTION=$EXPAND_DIRECTION SYSTEM_CODE=$SYSTEM_CODE"
}
generate_root_tag(){
	TAG_ID=$TAGSET_ID
	IS_SYSTEM=Y
	SYSTEM_CODE=$TAGSET_ID
	PARENT_TAG=NULL
	PARENT_TAG_ENV_ID=NULL
	PARENT_TAG_RELEASE_ID=NULL
	PREVIOUS_TAG=NULL
	PREVIOUS_TAG_ENV_ID=NULL
	PREVIOUS_TAG_RELEASE_ID=NULL
	LEFT_VAL=0
	RIGHT_VAL=`expr $NUM_TAGS \* 2 + 1`
	DEPTH_VAL=0
	DISPLAY_ORDER='1'
	DISPLAY_NAME=${DISPLAY_NAMES[0]}
	EXPAND_DIRECTION='NONE'
	PARENT_0=@TAG.$TAG_ID
}
set_left_right_vals(){
	if  is_parent; then
		let LEFT_VAL=$LEFT_VAL+1
		count_children $COUNTER
		LAST_CHILDREN=$?
		let RIGHT_VAL=$LEFT_VAL+`expr $LAST_CHILDREN \* 2 + 1`
	elif begin_new_level $COUNTER-1; then
		let LEFT_VAL=LEFT_VAL+1
		let RIGHT_VAL=LEFT_VAL+1
	else 
		let LEFT_VAL=LEFT_VAL+2
		let RIGHT_VAL=LEFT_VAL+1
	fi	
}
set_parent(){
	let PARENT_DEPTH=DEPTH_VAL-1
	PARENT_TAG=$(eval "echo \$PARENT_$PARENT_DEPTH")
	PARENT_TAG_ENV_ID=@ENV.Dflt
	PARENT_TAG_RELEASE_ID=@RELEASE.ID
	if is_parent; then
		eval "PARENT_$DEPTH_VAL=@TAG.${TAG_IDS[$COUNTER]}"

	fi
}
set_previous_tag(){
	if begin_new_level $COUNTER-1; then
		PREVIOUS_TAG=NULL
		PREVIOUS_TAG_ENV_ID=NULL
		PREVIOUS_TAG_RELEASE_ID=NULL
	elif end_level $COUNTER-1; then
		PREVIOUS_TAG=$(eval "echo \$PARENT_$DEPTH_VAL")
		PREVIOUS_TAG_ENV_ID=@ENV.Dflt
		PREVIOUS_TAG_RELEASE_ID=@RELEASE.ID
	else
		PREVIOUS_TAG=@TAG.$TAG_ID
		PREVIOUS_TAG_ENV_ID=@ENV.Dflt
		PREVIOUS_TAG_RELEASE_ID=@RELEASE.ID
	fi
}
is_tag(){
	if end_level $COUNTER; then
		return 1
	elif begin_new_level $COUNTER; then
		return 1
	else
		return 0
	fi
}
contains(){
	for i in "${ASSIGNED_IDS[@]}"
	do
		if [ "$i" == "$1" ]; then
			return 0
		fi
		# or do whatever with individual element of the array
	done
	return 1
}
generate_tag(){
	TAG_BREAKER="----------------NEW TAG------------------"
	ARRAY_LENGTH=${#DISPLAY_NAMES[@]}
	TAG_ID=$(echo ${DISPLAY_NAMES[0]} | sed 's/ //g')
	RANDOM_STR=$(echo $(head /dev/urandom | tr -dc a-z | head -c 3))
	TRUNC_TAG_ID=${TAG_ID:0:6}$RANDOM_STR
	TAGSET_ID=$(echo "$TRUNC_TAG_ID" | awk '{print tolower($0)}')

	number_of_tags
	generate_root_tag
	#print_tag
	SQL=$TAG_BREAKER$'\n'$(sql_tag)

	declare -a TAG_IDS
	COUNTER=1
	ASSIGNED_IDS=('hola' 'adios')
	while [ $COUNTER -lt $ARRAY_LENGTH ]; do
		if is_tag; then
			SANITISE_ID=$(echo ${DISPLAY_NAMES[$COUNTER]} | sed 's/ //g' | sed 's/-//g'| sed 's,/,,g')
			TRUNC_TAG_NAME=$TAGSET_ID$'_'${SANITISE_ID:0:20}
			NEW_ID_NAME=$(echo $TRUNC_TAG_NAME | awk '{print tolower($0)}')
			#if alread exist assign last three characters randomly
			if contains $NEW_ID_NAME; then
				RANDOM_STR=$(echo $(head /dev/urandom | tr -dc a-z | head -c 3))
				NEW_ID_NAME=${NEW_ID_NAME::-3}$RANDOM_STR
			fi
			ASSIGNED_IDS+=($NEW_ID_NAME)
			TAG_IDS[$COUNTER]=$NEW_ID_NAME
		fi
			let COUNTER=COUNTER+1
	done
	#print_tag

	EXPAND_DIRECTION=NULL
	COUNTER=1
	while [ $COUNTER -lt $ARRAY_LENGTH ]; do
		if begin_new_level $COUNTER; then
			let DEPTH_VAL=DEPTH_VAL+1
		elif end_level $COUNTER; then
			let LEFT_VAL=LEFT_VAL+2
			let DEPTH_VAL=DEPTH_VAL-1
		else
			IS_SYSTEM=N
			set_previous_tag
			TAG_ID=${TAG_IDS[$COUNTER]}
			SYSTEM_CODE=$TAG_ID
			DISPLAY_NAME=${DISPLAY_NAMES[$COUNTER]}
			DISPLAY_ORDER=NULL
			set_left_right_vals
			set_parent
			CURRENT_SQL=$'\n\n'$TAG_BREAKER$'\n'$(sql_tag)
			SQL=$SQL$CURRENT_SQL
			#echo for index: $COUNTER and item ${DISPLAY_NAMES[$COUNTER]}
			#print_tag
		fi
		let COUNTER=COUNTER+1
	done
	echo -e "$SQL"
}
