#!/bin/bash
. ./sql/sql-parser.sh
. ./sql/template-value-builder.sh
extend_entity_sql(){
	set_value SUPER_ENTITY_DEFINITION NULL
	set_value ENTITY_NAME "Base$ENTITY_NAME_TO_EXTEND"
	ENTITY_DISP_NAME=${ENTITY_ID#*.}
  ENTITY_TYPE=@ET.$ENTITY_DISP_NAME

	parse_template extend-entity.sql	
	sql=$last_parsed_template
}
