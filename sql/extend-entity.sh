#!/bin/bash

extend_entity_sql(){
	set_value SUPER_ENTITY_DEFINITION NULL
	set_value ENTITY_NAME "Base$ENTITY_NAME_TO_EXTEND"
	parse_template extend-entity.sql	
}
