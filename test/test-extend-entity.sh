#!/bin/bash

. ./test/config/config.sh
. ./test/libs/assert.sh

T__generate_extend_entity(){
	. ./sql/extend-entity.sh

	ENTITY_NAME_TO_EXTEND="CustomerED"
	INTERFACE_PATH="CoreEntities.API.Interfaces.EICustomer"
	LOGICAL_OBJ_PATH="CoreEntities.Implementation.Customer.Customer"
	ENTITY_ID="@ED.SPENCustomer"
	EXT_INTERFACE_PATH="SPENCustomer.API.EISPENCustomer"
	EXT_LOGICAL_OBJ_PATH="SPENCustomer.Implementation.Customer.Objects.SPENCustomer"

	expected_sql=$(cat $expected_sql_files/extend-entity.sql)

	extend_entity_sql

	assert_equal_sql "$expected_sql" "$sql"
}
