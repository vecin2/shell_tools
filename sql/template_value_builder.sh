#!/bin/bash

export PLACE_HOLDERS=()
prompt_enter_value(){
	LABEL=$1
	if [ "$3" ]; then
		DEFAULT_VALUE=$3
		LABEL="${LABEL} (default is $DEFAULT_VALUE)"
	fi	
	read -p "$LABEL:" VALUE
	if [[ -z "$VALUE" ]]; then
		VALUE=$DEFAULT_VALUE
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
	eval "export $1=\"$2\""
	PLACE_HOLDERS+=($1)
}
