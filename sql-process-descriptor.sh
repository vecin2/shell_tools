#!/bin/sh
#read -e -p 

. ./sql-base.sh

SQL_MODULE=/PruCustomer/sqlScripts/oracle/updates/Pru_R3_0_1/SendLetterAction
REVISION=12162
PROCESS_DESCRIPTOR_NAME=SendLetter
PROCESS_DESCRIPTOR_DESCRIPTION="Invokes letter service to invoke letter as part of the noticiation service"
REPOSITORY_PATH=PruCustomer.Implementation.UnreadDocumentation.Actions.SendLetter
CONFIG_PROCESS_ID=null
#Type 2. Action 3. SLA
TYPE=2

SQL="INSERT INTO EVA_PROCESS_DESCRIPTOR (ID, ENV_ID, NAME, REPOSITORY_PATH, CONFIG_PROCESS_ID, IS_DELETED, TYPE) VALUES (@PD.$PROCESS_DESCRIPTOR_NAME, @ENV.Dflt, '$PROCESS_DESCRIPTOR_NAME', '$REPOSITORY_PATH', $CONFIG_PROCESS_ID, 'N', $TYPE);\n
INSERT INTO EVA_PROCESS_DESCRIPTOR_LOC (ID, ENV_ID, LOCALE, DISPLAY_NAME, DESCRIPTION) VALUES (@PD.$PROCESS_DESCRIPTOR_NAME, @ENV.Dflt, 'en-GB', '$PROCESS_DESCRIPTOR_NAME', '$PROCESS_DESCRIPTOR_DESCRIPTION');"
echo "$SQL"
#create_sql_module $SQL_MODULE $REVISION "$SQL"
