#!/bin/sh
#read -e -p 

. ./sql-base.sh
SQL_MODULE=SGroupAddChannelsReportingFactsSchema/sqlScripts/oracle/updates/SG0_3/AddReasonToFactInteraction
REVISION=521


SQL="
alter table FACT_AD_INTERACTION_SUMMARY 
add  CONTACTREASON_GROUP_ID NUMBER(9);
alter table FACT_AD_INTERACTION 
add  CONTACTREASON_GROUP_ID NUMBER(9);"

create_sql_module $SQL_MODULE $REVISION "$SQL"
