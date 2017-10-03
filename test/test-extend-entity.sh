#!/bin/bash



T__generate_extend_entity(){
	ENTITY_NAME_TO_EXTEND=CustomerED
	INTERFACE_PATH="CoreEntities.API.Interfaces.EICustomer"
	LOGICAL_OBJ_PATH="CoreEntities.Implementation.Customer.Customer"
	ENTITY_ID="SPENCustomer"
	EXT_INTERFACE_PATH="SPENCustomer.API.EISPENCustomer"
	EXT_LOGICAL_OBJ_PATH="SPENCustomer.Implementation.Customer.Objects.SPENCustomer"

	#extend_entity_sql

#	assert_equals_sql "$expected_sql" "$sql"
}
