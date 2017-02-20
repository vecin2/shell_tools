#!/bin/sh
#read -e -p 

. ./sql-base.sh

SQL_MODULE=/PruCaseHandling/sqlScripts/oracle/updates/Pru_R3_0_1/ConfigChaseIllustrationPD
REVISION=11913


SQL="update EVA_PROCESS_DESCRIPTOR set (CONFIG_PROCESS_ID)= (@PD.ChangeStateActionSLAConfig) where id = @PD.ChaseIllustration;"



create_sql_module $SQL_MODULE $REVISION "$SQL"
