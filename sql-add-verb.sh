#!/bin/sh
#read -e -p 

. ./sql-base.sh

SQL_MODULE=SGroupContactHistory/sqlScripts/oracle/updates/SG0_3/InlineViewContctReasons
REVISION=429
VERB_NAME=inlineViewContactReasons
PROCESS_PATH='SGroupContactHistory.Implementation.Contact.Verbs.ContactReasonSelectorProcess'
ED=Contact

SQL="-- ADDING VERB $VERB_NAME
INSERT INTO EVA_PROCESS_DESCRIPTOR (ID,
ENV_ID,
NAME,
REPOSITORY_PATH,
CONFIG_PROCESS_ID,
IS_DELETED,
TYPE) VALUES (
@PD.$VERB_NAME,
@ENV.Dflt,
'$VERB_NAME',
'$PROCESS_PATH',
NULL,
'N',
0);
INSERT INTO EVA_PROCESS_DESCRIPTOR_LOC (ID, ENV_ID, LOCALE, DISPLAY_NAME, DESCRIPTION) VALUES (@PD.$VERB_NAME, @ENV.Dflt, 'en-GB', '$VERB_NAME', '$VERB_NAME');
INSERT INTO EVA_PROCESS_DESC_REFERENCE (ID, PROCESS_DESCRIPTOR_ID, PROCESS_DESCRIPTOR_ENV_ID, CONFIG_ID, IS_SHARED) VALUES (@PDR.$VERB_NAME, @PD.$VERB_NAME, @ENV.Dflt, NULL, 'N');

INSERT INTO EVA_VERB (ID, NAME, PROCESS_DESC_REF_ID, ENTITY_DEF_ID, ENTITY_DEF_ENV_ID, IS_INSTANCE, IS_DEFAULT, IS_INSTANCE_DEFAULT, IS_USER_VISIBLE, RECORD_FOR_WRAPUP, DISPLAY_AT_WRAPUP, RELEASE_ID, IS_LAUNCHABLE_TASK)
VALUES (
@V.$VERB_NAME, --ID
'$VERB_NAME', --name 
@PDR.$VERB_NAME, --PROCESS_DESC_REF_ID
@ED.$ED,--ENTITY_DEF_ID
@ENV.Dflt,--ENTITY_DEF_ENV_ID
'Y',--IS_INSTANCE
'N',-- IS_DEFAULT
'N',-- IS_INSTANCE_DEFAULT
'Y', --IS_USER_VISABLE
'Y', --RECORD_FOR_WRAPUP
'N', --DISPLAY_AT_WRAPUP
@RELEASE.ID, --RELEASE_ID
NULL
);
INSERT INTO EVA_VERB_LOC (ID, LOCALE, DISPLAY_NAME, DESCRIPTION) VALUES (@V.$VERB_NAME, 'en-GB', '$VERB_NAME', '$VERB_NAME');"


create_sql_module $SQL_MODULE $REVISION "$SQL"
