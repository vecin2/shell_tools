#!/bin/bash

. ./sql-base.sh
. ./sql-tag-base.sh

SQL_MODULE=/SGroupContactHistory/sqlScripts/oracle/updates/SG0_3/AddTagctAllOrgContactReasons
REVISION=995

#MM/DD/YYYY HH:MI:SS AM
DATE="05/29/2017"
declare -a DISPLAY_NAMES=('Organisation All Contact Reasons' 
					'['
					   'Default Queue'
					   '[' 
					      'Transferred to MaRa Queue'
					      'Transferred to S-Bank Queue'
					   ']'   
					']')
#
SQL=$(generate_tag $1)
echo "$SQL"
create_sql_module $SQL_MODULE $REVISION "$SQL"

