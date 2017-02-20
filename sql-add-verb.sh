#!/bin/sh
#read -e -p 

. ./sql-base.sh

SQL_MODULE=/PruCaseHandling/sqlScripts/oracle/updates/Pru_R3_0_1/PullDownInlineCreate
REVISION=11673


SQL="INSERT INTO EVA_VERB (ID, NAME, PROCESS_DESC_REF_ID, ENTITY_DEF_ID, ENTITY_DEF_ENV_ID, IS_INSTANCE, IS_DEFAULT, IS_INSTANCE_DEFAULT, IS_USER_VISIBLE, RECORD_FOR_WRAPUP, DISPLAY_AT_WRAPUP, RELEASE_ID, IS_LAUNCHABLE_TASK)\n
VALUES (\n
@V.PruInlineCreateIllPenInc, --ID\n
'inlineCreate', --name \n
@PDR.PruInlineCreateAccIllustration, --PROCESS_DESC_REF_ID\n
@ED.PruIllustrationPensionIncome,--ENTITY_DEF_ID\n
@ENV.Dflt,--ENTITY_DEF_ENV_ID\n
'Y',--IS_INSTANCE\n
'N',-- IS_DEFAULT\n
'N',-- IS_INSTANCE_DEFAULT\n
'Y', --IS_USER_VISABLE\n
'Y', --RECORD_FOR_WRAPUP\n
'Y', --DISPLAY_AT_WRAPUP\n
@RELEASE.ID, --RELEASE_ID\n
'Y'\n
);\n
INSERT INTO EVA_VERB_LOC (ID, LOCALE, DISPLAY_NAME, DESCRIPTION) VALUES (@V.PruInlineCreateIllPenInc, 'en-GB', 'Create Illustration Pension Income', 'Create Illustration Pension Income');\n
UPDATE EVA_VERB set (ENTITY_DEF_ID)=(@ED.PruAccumulationIllustration) where ID=@V.PruInlineCreateAccIllustration;"


create_sql_module $SQL_MODULE $REVISION "$SQL"
