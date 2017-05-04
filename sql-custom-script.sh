#!/bin/sh 

. ./sql-base.sh
SQL_MODULE=SGroupFrameworkEVA/sqlScripts/oracle/updates/SG0_3/OrganisationTagData2
REVISION=609


SQL="
insert into SGROUP_ORGANISATION_TAG (ORG_SYSTEM_CODE, TAG_SYSTEM_CODE, TAG_TYPE_CODE)
values('organisat_mara','maracocae','contactReasons');"

create_sql_module $SQL_MODULE $REVISION "$SQL"
