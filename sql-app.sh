#!/bin/bash
#read -e -p 

. ./sql-base.sh
. ./svn-rev-number.sh

if [ $# -eq 1 ]; then
	REVISION=$(svn_rev_number)
elif [ $# -eq 2 ]; then
	REVISION=$2
else
	echo Usage:
	echo " module: (e.g SGroupContactHistory/sqlScripts/oracle/updates/SG0_3/IncreaseDisplaySpaceContactReasons2)"
	echo " (optional) revision: (eg. 857)"
	exit 1
fi

MODULE=$1

echo "Welcome! Current rev number is $REVISION"

echo "The sql will be generated in  $MODULE/tableData.sql"

show_menu(){
	printf '\n'
	echo " What would you like to do?
	x.  Exit
	pd. Process Descriptor
	ee. Extend Entity
	ape. Add Persistable Entity 
	ace. Add Child Entity 
	ue. Update Entity 
	av. Add verb
	rv. Rewire verb
	avp. Add verb to process desc refernce
	am. Add monitor
	rm. Remove monitor
	ar. Add Report
	ae. Add Entitlement
	me. Map Entitlement
	ms. Modify Schema
	cs. Custom Script"
	read -p "Please enter option number: " OPTION
	printf '\n'
}
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
modify_schema(){
	read_value TABLE_NAME TABLE_NAME
	parse_template create-table.sql
}
add_process_desc_reference(){
	read_value PROCESS_DESC_REF_ID PROCESS_DESC_REF_ID
	read_value PROCESS_DESCRIPTOR_ID PROCESS_DESCRIPTOR_ID $PROCESS_DESC_REF_ID
	parse_template add-process-desc-reference.sql
}
add_process_descriptor(){
	read_value PROCESS_DESCRIPTOR_NAME PROCESS_DESCRIPTOR_NAME
	read_value Description PROCESS_DESCRIPTOR_DESCRIPTION 
	read_value "Repository path" REPOSITORY_PATH
	read_value "Config process id" CONFIG_PROCESS_ID NULL
	read_value "Type id (0=regular process, 2=Action, 3=SLA) - default is 0:" TYPE
	#echo $(./template-process-descriptor.sh )
	parse_template add-process-descriptor.sql
}
add_standard_verb_path(){
	set_value CONFIG_PROCESS_ID NULL
	set_value TYPE 0
	add_process_descriptor

	set_value PROCESS_DESC_REF_ID $PROCESS_DESCRIPTOR_NAME
	set_value PROCESS_DESCRIPTOR_ID $PROCESS_DESCRIPTOR_NAME
	add_process_desc_reference

	set_value PROCESS_DESC_REF_ID $PROCESS_DESC_REF_ID
}
add_verb(){
	add_standard_verb_path
	add_verb_to_pdr
}
rewire_verb(){
	add_standard_verb_path
	read_value ENTITY_DEF_ID ENTITY_DEF_ID
	read_value VERB_NAME VERB_NAME
	parse_template rewire-verb.sql
}
add_verb_to_pdr(){
	read_value VERB_ID VERB_ID $PROCESS_DESCRIPTOR_NAME
	read_value VERB_NAME VERB_NAME
	read_value ENTITY_DEF_ID ENTITY_DEF_ID
	read_value PROCESS_DESC_REF_ID PROCESS_DESC_REF_ID
	read_value "IS_INSTANCE (Y/N)" IS_INSTANCE
	read_value IS_USER_VISIBLE IS_USER_VISIBLE
	read_value RECORD_FOR_WRAPUP RECORD_FOR_WRAPUP
	read_value "IS_LAUNCHABLE_TASK(please enter with ' -->'Y'/'N'):" IS_LAUNCHABLE_TASK "NULL"
	parse_template add-verb.sql
}
extend_entity(){
	set_value SUPER_ENTITY_DEFINITION NULL
	read_value "NEW_BASE_ENTITY (e.g BaseContact)" NEW_BASE_ENTITY
	read_value "LOGICAL_OBJ_PATH (e.g CoreContactHistory.Implementation.Contact.Contact)" LOGICAL_OBJ_PATH
	read_value "INTERFACE_PATH (e.g CoreContactHistory.API.Interfaces.EIContact)" INTERFACE_PATH
}
add_persistable_entity(){
	set_value SUPER_ENTITY_DEFINITION PersistableEntity
	add_child_entity
}
add_child_entity(){
	read_value ENTITY_ID ENTITY_ID
	read_value LOGICAL_OBJ_PATH LOGICAL_OBJ_PATH
	read_value INTERFACE_PATH INTERFACE_PATH
	read_value SUPER_ENTITY_DEFINITION SUPER_ENTITY_DEFINITION
	parse_template add-entity-definition.sql
}
update_entity(){
	read_value LOGICAL_OBJ_PATH LOGICAL_OBJ_PATH
	read_value INTERFACE_PATH INTERFACE_PATH
	read_value ENTITY_NAME ENTITY_NAME
	read_value ENTITY_ID ENTITY_ID
	parse_template update-entity.sql
}
add_monitor(){
	read_value MONITOR_ID MONITOR_ID
	read_value MONITOR_REPO_PATH MONITOR_REPO_PATH
	read_value START_REPO_PATH START_REPO_PATH
	read_value "SEQUENCE_NO from EVA_DYNAMIC_VERB_LIST" SEQUENCE_NO
	parse_template add-monitor.sql
        #set_value TYPE 0
	#add_process_descriptor
}
remove_monitor(){
	read_value "Monitor repo path(e.g Common.Implementation.Monitor)" REPOSITORY_PATH	
	read_value DYNAMIC_VERB_ID_LIST DYNAMIC_VERB_ID_LIST
	parse_template remove-monitor.sql
}
add_report(){
	read_value "Report Name(ID)" REPORT_NAME
	read_value "MENU_ID (default OpPerformanceReports)" MNI_ID OpPerformanceReports
	read_value "Report url from (...SGroup_Reporting/Interaction_Reporting/reports)"  REPORT_URL
	parse_template add-report.sql
	#read_value REPORT_DISPLAY_NAME REPORT_DISPLAY_NAME 
	#read_value REPORT_DESCRIPTION REPORT_DESCRIPTION
	prompt_enter_value "Enter locations (e.g. en-GB,fi-FI)" "LOCALE"
	IFS=',' read -r -a LOCALES <<< "$LOCALE"
	for LOCALE_ITEM in "${LOCALES[@]}" 
	do
		prompt_enter_value "$LOCALE_ITEM-DISPLAY_NAME" LOC_DISPLAY_NAME
		prompt_enter_value "$LOCALE_ITEM-LOC_DESCRIPTION" LOC_DESCRIPTION $LOC_DISPLAY_NAME
		parse_template add-report-locale.sql
	done
	#add location

}
add_entitlement(){
	read_value "ID" ENT_ID
	read_value "Display Name" ENT_DISP_NAME 
	read_value "System Name" ENT_SYSTEM_NAME
	parse_template add-entitlement.sql
}

generate(){
	read -p "Please enter a comment for this script:" COMMENT
	SQL_COMMENT="--$COMMENT"
	CURRENT_SQL="$($1)"; echo "Generating SQL:\n $CURRENT_SQL"; SQL=$SQL$SQL_COMMENT$'\n'$CURRENT_SQL$SEPARATOR; 
	PLACE_HOLDERS=()
}
map_entitlement(){
	prompt_enter_value "ENTITLEMENT_ID (e.g. ChatReports)" ENTITLEMENT_ID
	prompt_enter_value "ENTITY_ID (e.g @PROFILE.SUPERVISOR)" ENTITY_ID
	prompt_enter_value "ENTIY_TYPE_ID (e.g ProfileType)" ENTITY_TYPE_ID
	parse_template map-entitlement.sql	
}
PLACE_HOLDERS=()
show_menu
SEPARATOR=$'\n\n\n'
while  [ "$OPTION" != "x" ];do 
	case $OPTION in
		x   )  return ;;
		ms  ) generate modify_schema ; FILE_NAME=createTables.sql ; break ;; 
		cs  ) break ;; 
		pd  ) generate add_process_descriptor ;;
		ee  ) generate extend_entity ;;
		ape ) generate add_persistable_entity ;;
		ace ) generate add_child_entity ;;
		ue  ) generate update_entity ;;
		av  ) generate add_verb ;;
		rv  ) generate rewire_verb ;;
		avp ) generate add_verb_to_pdr ;;
		am  ) generate add_monitor ;;
		ar  ) generate add_report ;;
		ae  ) generate add_entitlement ;;
		me  ) generate map_entitlement ;;
		rm  ) generate remove_monitor ;;
		*   ) echo Please enter a valid option ;;
       	esac
	show_menu
done


echo $SQL
create_sql_module $MODULE $REVISION "$SQL" $FILE_NAME
