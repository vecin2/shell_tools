#!/bin/sh
#read -e -p 

. ./sql-base.sh
SQL_MODULE=/PruCaseHandling/sqlScripts/oracle/updates/Pru_R3_0_1/RemoveIllustrationVerbs
REVISION=12022


echo starting
SQL=$(
delete_verb @V.PruEmbeddedEditAccuIllus; 
delete_verb @V.PruCreateAccIllustration
)
echo finishing creating sql
create_sql_module $SQL_MODULE $REVISION "$SQL"
