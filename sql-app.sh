#!/bin/bash
#read -e -p 

. ./sql-base.sh

if [ $# -ne 2 ]; then
	echo Usage:
	echo " module: (e.g SGroupContactHistory/sqlScripts/oracle/updates/SG0_3/IncreaseDisplaySpaceContactReasons2)"
	echo " update sequence number"
	exit 1
fi
MODULE=$1
REVISION=$2

echo "Welcome!"

echo "The sql will be generated in  $MODULE/tableData.sql"

show_menu(){
	printf '\n'
	echo " What would you like to do?
	x.  Exit
	pd. Process Descriptor
	am. Add monitor
	rm. Remove monitor
	ms. Modify Schema
	cs. Custom Script"
	read -p "Please enter option number: " OPTION
	printf '\n'
}
read_value(){
	#if place holders contains the variable--> if the variable has not yet been initialized
	if [[ ! " ${PLACE_HOLDERS[@]} " =~ " $2 " ]]; then
		read -p "$1:" VALUE
		set_value $2 $VALUE
	fi

}
set_value(){
	eval "export $1=$2"
	PLACE_HOLDERS+=($1)
}
add_process_descriptor(){
	read_value ID PROCESS_DESCRIPTOR_NAME
	read_value Description PROCESS_DESCRIPTOR_DESCRIPTION 
	read_value "Repository path" REPOSITORY_PATH
	read_value "Config process id:" CONFIG_PROCESS_ID
	read_value "Type id (2=Action, 3=SLA):" TYPE
	#echo $(./template-process-descriptor.sh )
	parse_template add-process-descriptor.sql
}
add_monitor(){
	read_value MONITOR_ID MONITOR_ID
	read_value MONITOR_REPO_PATH MONITOR_REPO_PATH
	read_value START_REPO_PATH START_REPO_PATH
	read_value SEQUENCE_NO SEQUENCE_NO
	parse_template add-monitor.sql
        #set_value TYPE 0
	#add_process_descriptor
}
remove_monitor(){
	read_value "Monitor repo path" REPOSITORY_PATH	
	read_value DYNAMIC_VERB_ID_LIST DYNAMIC_VERB_ID_LIST
	parse_template remove-monitor.sql
}

generate(){
CURRENT_SQL="$($1)"; echo "Generating SQL:\n $CURRENT_SQL"; SQL=$SQL$SEPARATOR$CURRENT_SQL; 
PLACE_HOLDERS=()
}

PLACE_HOLDERS=()
show_menu
SEPARATOR=$'\n\n\n'
while  [ "$OPTION" != "x" ];do 
	case $OPTION in
		[x]* )  return ;;
		[ms]* ) MODIFY_SCHEMA=true; break ;; 
		[cs]* ) break ;; 
		[pd]* ) generate add_process_descriptor ;;
		[am]* ) generate add_monitor ;;
		[rm]* ) generate remove_monitor ;;
       	esac
	show_menu
done


echo $SQL
echo creating module with modify schema: $MODIFY_SCHEMA
create_sql_module $MODULE $REVISION "$SQL" $MODIFY_SCHEMA
