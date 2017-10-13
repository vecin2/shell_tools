#!/bin/bash

. ./sql/extend-entity.sh
. .scripts/sql/value-reader.sh

#ask for parameters

read_value "Entity name you would like to extend(e.g CustomerED)" ENTITY_NAME_TO_EXTEND
read_value "Interface path you would like to override (e.g. CoreEntities.API.Interfaces.EICustomer)" INTERFACE_PATH
read_value "Logical object path you would like to override(e.g CoreEntities.Implementation.Customer.Customer)" LOGICAL_OBJ_PATH
read_value "New entity id" ENTITY_ID "@ED."
read_value "New Interface path (e.g. SPENCustomer.API.EISPENCustomer)" EXT_INTERFACE_PATH
read_value "New logical object path (e.g SPENCustomer.Implementation.Customer.Objects.SpenCustomer)" EXT_LOGICAL_OBJ_PATH
extend_entity_sql
echo $sql




