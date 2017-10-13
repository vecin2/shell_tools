#!/bin/bash

. ./sql/extend-entity.sh
. ./sql/value-reader.sh

#ask for parameters

#read_value "Entity definition name you would like to extend(e.g CustomerED)" ENTITY_NAME_TO_EXTEND
#read_value "Interface path you would like to override (e.g. CoreEntities.API.Interfaces.EICustomer)" INTERFACE_PATH
#read_value "Logical object path you would like to override(e.g CoreEntities.Implementation.Customer.Customer)" LOGICAL_OBJ_PATH
#read_value "New entity id" ENTITY_ID "@ED."
#read_value "New Interface path (e.g. SPENCustomer.API.EISPENCustomer)" EXT_INTERFACE_PATH
#read_value "New logical object path (e.g SPENCustomer.Implementation.Customer.Objects.SpenCustomer)" EXT_LOGICAL_OBJ_PATH
extend_entity_sql
read_sql_path "Enter the module sql path:" MODULE_PATH
read_repo_path "Interface path to override" interface_path
read_repo_path "Logical object path to override" logical_obj_path
read_prj_path "New interface path" ext_interface_path
read_prj_path "New logical object path" ext_interface_path
#table_path=$(create_sql_file $xml "tableData")
#generate_update_seq $path
#
#extend_entity_xml $INTERFACE_PATH
##print_xml_to_file $xml $EXT_INTERFACE_PATH
#implement_entiy_xml $INTERFACE_PATH
#
echo $sql




