#!/bin/sh
#read -e -p 

. ./sql-base.sh

SQL_MODULE=/PruCaseHandling/sqlScripts/oracle/updates/Pru_R3_0_1/PullUpInlineCreate
REVISION=11661

SQL="UPDATE EVA_VERB
set (ENTITY_DEF_ID)=(@ED.PruBaseIllustrationED)
where ID=@V.PruInlineCreateAccIllustration;\n

delete from EVA_VERB_LOC
where ID = @V.PruInlineCreateIllPenInc;\n

delete from EVA_VERB
where ID = @V.PruInlineCreateIllPenInc;"

create_sql_module $SQL_MODULE $REVISION "$SQL"
