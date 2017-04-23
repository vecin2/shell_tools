#!/bin/sh
#read -e -p 

. ./sql-base.sh
SQL_MODULE=SGroupFrameworkEVA/sqlScripts/oracle/updates/SG0_3/OrganisationTagData
REVISION=473


SQL="insert into SGROUP_ORGANISATION_TAG (ORG_SYSTEM_CODE, TAG_SYSTEM_CODE, TAG_TYPE_CODE)
values('organisat_sbank','sbankcxkl','contactReasons');
insert into SGROUP_ORGANISATION_TAG (ORG_SYSTEM_CODE, TAG_SYSTEM_CODE, TAG_TYPE_CODE)
values('organisat_mara','maracocae','contactReasons');"

create_sql_module $SQL_MODULE $REVISION "$SQL"
