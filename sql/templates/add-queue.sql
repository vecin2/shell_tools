
INSERT INTO FRB_RULE_SET (ID, NAME, TYPE, VERSION, FACTS_LIST, RULESET_JSON, ENV_ID, IS_DELETED, ENTITY_REFERENCES, IS_ORIGINAL) VALUES (@RS.${QUEUE_NAME}, '${QUEUE_NAME}', 'Queue', 1, NULL, '{\"name\": \"${QUEUE_NAME}\", \"description\":\"Rule Set for the queue ${QUEUE_DISPLAY_NAME}\", \"rules\":[]}', @ENV.ID, 'N', NULL, 'Y');
INSERT INTO CWQ_QUEUE (ID,ENV_ID, RELEASE_ID, NAME, DESCRIPTION, IS_DELETED, TRANSFER_ENTITLEMENT_ID, TRANSFER_ENTITLEMENT_ENV_ID, RULE_SET_NAME, UUID, IS_OWNED) VALUES (@QUEUE.${QUEUE_NAME}, @ENV.Dflt,@RELEASE.ID,'${QUEUE_DISPLAY_NAME}','${QUEUE_DISPLAY_NAME}', 'N',NULL, NULL, '${QUEUE_NAME}', '${QUEUE_NAME}','N');
INSERT INTO CWQ_QUEUE_LOC (ID,ENV_ID,RELEASE_ID,LOCALE,DISPLAY_NAME,DESCRIPTION) VALUES (@QUEUE.${QUEUE_NAME}, @ENV.Dflt, @RELEASE.ID, 'en-GB', '${QUEUE_DISPLAY_NAME}', '${QUEUE_DISPLAY_NAME}');
INSERT INTO CW_WORKLIST_DISPLAY_TEXT_LOC (ID, ENV_ID, TYPE_ID, TYPE_ENV_ID, RELEASE_ID, DISPLAY_TEXT, LOCALE) VALUES (@QUEUE.${QUEUE_NAME}, @ENV.Dflt, @ET.Queue, @ENV.Dflt, @RELEASE.ID, '${QUEUE_DISPLAY_NAME}', 'en-GB');

