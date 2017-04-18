#!/bin/bash

. ./sql-base.sh
. ./sql-tag-base.sh

SQL_MODULE=/SGroupContactHistory/sqlScripts/oracle/updates/SG0_3/CreateTagContactReasonTest1
REVISION=400

#MM/DD/YYYY HH:MI:SS AM
DATE="04/17/2017"
declare -a DISPLAY_NAMES=('SBank Contact Reasons Test1' 
					'[' 
					   'AO-asiat'
					   '[' 
					      'Hola/Adios'
					      'Bonusasiat'
					    ']' 
					   'Mortgage' 
					   '[' 
					      'Bonusasiat'
					      'Cancel Mortgage' 
					      'Activate  Mortgage' 
					   ']' 
					']')

SQL=$(generate_tag)
echo "$SQL"
create_sql_module $SQL_MODULE $REVISION "$SQL"

