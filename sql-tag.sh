#!/bin/bash

. ./sql-base.sh
. ./sql-tag-base.sh

SQL_MODULE=/SGroupContactHistory/sqlScripts/oracle/updates/SG0_3/CreateTagContactReasonTest1
REVISION=398

#MM/DD/YYYY HH:MI:SS AM
DATE="04/17/2017"

declare -a DISPLAY_NAMES=('Contact Reasons test 2' 
					'[' 
					   'Bank Account' 
					   '[' 
					      'Open Account' 
					      'Close Account' 
					      'Creating a 123 account but dont close' 
					   ']' 
					   'Mortgage' 
					   '[' 
					      'Open Mortgage' 
					      'Cancel Mortgage' 
					      'Activate  Mortgage' 
					   ']' 
					']')

SQL=$(generate_tag)
echo "$SQL"
create_sql_module $SQL_MODULE $REVISION "$SQL"

