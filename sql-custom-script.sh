#!/bin/sh
#read -e -p 

. ./sql-base.sh
SQL_MODULE=SGroupContactHistory/sqlScripts/oracle/updates/SG0_3/IncreaseDisplaySpaceContactReasons2
REVISION=551


SQL="
-- move the OOTB verb to the base entity
UPDATE EVA_VERB 
SET (ENTITY_DEF_ID) = (@ED.BaseContactHistoryEntitiyDefinition) 
WHERE ID = @V.ContactHistoryViewContactInteraction
AND RELEASE_ID = @RELEASE.ID;

INSERT INTO EVA_PROCESS_DESCRIPTOR (ID, ENV_ID, NAME, REPOSITORY_PATH, CONFIG_PROCESS_ID, IS_DELETED, TYPE) 
VALUES (@PD.SGroupContactHistoryViewContactInteraction, @ENV.Dflt, 'SGroupContactHistoryViewContactInteraction','SGroupContactHistory.Implementation.Contact.Processes.ViewWrapper', NULL, 'N', 0);
INSERT INTO EVA_PROCESS_DESCRIPTOR_LOC (ID, ENV_ID, LOCALE, DISPLAY_NAME, DESCRIPTION) VALUES (@PD.SGroupContactHistoryViewContactInteraction, @ENV.Dflt, 'en-GB', 'SGroupContactHistoryViewContactInteraction', 'SGroupContactHistoryViewContactInteraction');
INSERT INTO EVA_PROCESS_DESC_REFERENCE (ID, PROCESS_DESCRIPTOR_ID, PROCESS_DESCRIPTOR_ENV_ID, CONFIG_ID, IS_SHARED) VALUES (@PDR.SGroupContactHistoryViewContactInteraction, @PD.SGroupContactHistoryViewContactInteraction, @ENV.Dflt, NULL, 'N');

INSERT INTO EVA_VERB (ID, NAME, PROCESS_DESC_REF_ID, ENTITY_DEF_ID, ENTITY_DEF_ENV_ID, IS_INSTANCE, IS_DEFAULT, IS_INSTANCE_DEFAULT, IS_USER_VISIBLE, RECORD_FOR_WRAPUP, DISPLAY_AT_WRAPUP, RELEASE_ID, IS_LAUNCHABLE_TASK) VALUES (@V.SGroupContactHistoryViewContactInteraction, 'viewContactInteraction', @PDR.SGroupContactHistoryViewContactInteraction, @ED.Contact, @ENV.Dflt, 'Y', 'N', 'N', 'N', 'Y', 'N', @RELEASE.ID, NULL);
INSERT INTO EVA_VERB_LOC (ID, LOCALE, DISPLAY_NAME, DESCRIPTION, RELEASE_ID) VALUES (@V.SGroupContactHistoryViewContactInteraction, 'en-GB', 'SGroupContactHistoryViewContactInteraction', 'SGroupContactHistoryViewContactInteraction', @RELEASE.ID);"

create_sql_module $SQL_MODULE $REVISION "$SQL"
