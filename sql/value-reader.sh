#!/bin/bash

. ./configuration.sh

export PLACE_HOLDERS=()
prompt_enter_value(){
	LABEL=$1
	if [ "$3" ]; then
		predef_value=$3
		LABEL="${LABEL}"
	else
		predef_value=""
	fi	
	read -e -p "$LABEL:"  -i "$predef_value" VALUE
	while contains "$VALUE" "\*" 
	do
		echo Grepping file $CORE_HOME/work/modifiable.id.map.file
		grep --color=always -i "$VALUE" $CORE_HOME/work/modifiable.id.map.file
		read -e -p "$LABEL:" -i "$VALUE" VALUE
	done
	if [[ -z "$VALUE" ]]; then
		VALUE=$predef_value
	fi
	set_value "$2" "$VALUE"
}
read_value(){
	#if place holders contains the variable--> if the variable has not yet been initialized
	if [[ ! " ${PLACE_HOLDERS[@]} " =~ " $2 " ]]; then
		prompt_enter_value "$1" "$2" "$3"
	fi
}
set_value(){
	eval "$1=\"$2\""
	PLACE_HOLDERS+=($1)
}

contains() {
	string="$1"
	substring="$2"
	if test "${string#*$substring}" != "$string"
	then
		return 0    # $substring is in $string
	else
		return 1    # $substring is not in $string
	fi
}
read_sql_path(){
	read_value "$1" "$2" "../modules/$MODULES_PREFIX"
}
read_prj_path(){
	read_value "$1" "$2" "../repository/default/$MODULES_PREFIX"
}
read_repo_path(){
	read_value "$1" "$2" "../repository/default/"
}
