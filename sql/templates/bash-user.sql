INSERT INTO FU_USER (ID,USERNAME, LOCALE_ID, LOCALE_ENV_ID, IS_DELETED, VIRTUAL_ENVIRONMENT_ID, VIRTUAL_ENVIRONMENT_ENV_ID)
VALUES (@USER.$USERNAME,'$USERNAME',@LOC.EnglishGB, @ENV.Dflt, 'N',1,@ENV.Dflt);

INSERT INTO AGENT (USERNAME, PASSWORD, EXPIRES, PERSON_ID, CONNECTON, DISABLED, GRACE, CREATED, ALLOWCONCURRENT, CONSISTENTIPONLY, LOGINFAILURES, LASTLOGGEDIN, FULLNAME, ENCRYPTION_CLASSNAME, SALT)
VALUES ('$USERNAME','b428710cbdca288c7e4552dcd004cbe186a20be85300e2b70bca0432fd0b74a8',TO_DATE('21/07/2013','DD/MM/YYYY'),1,1,'no',0,SYSDATE,1,'no',0,NULL, '$FULLNAME', 'com.gtnet.common.security.algorithms.SHA256', 'Pop9OxwzI8E=');
INSERT INTO CE_PERSON (ID, FIRST_NAME, FIRST_NAME_UPPER, MIDDLE_NAME, LAST_NAME, LAST_NAME_UPPER, PREVIOUS_LAST_NAME, GENDER_ID, GENDER_ENV_ID, TITLE_ID, TITLE_ENV_ID, DATE_OF_BIRTH, IS_DELETED)
VALUES (@PERSON.$USERNAME, '$FIRST_NAME', 'FIRST_NAME_UPPER', NULL, 'LAST_NAME', 'LAST_NAME_UPPER', NULL, @GEND.$GENDER_ID, @ENV.Dflt, @TITLE.Mrs, @ENV.Dflt, SYSDATE, 'N');
INSERT INTO CE_AGENT (ID, USER_ID)
VALUES (@PERSON.$USERNAME, @USER.$USERNAME);

INSERT INTO FD_USER_PROFILE_TYPE ( USER_ID, PROFILE_TYPE_ID, PROFILE_TYPE_ENV_ID, IS_DELETED)
VALUES (@USER.$USERNAME, @PROFILE.KMSTANDALONE, @ENV.Dflt, 'N');
INSERT INTO FD_USER_PROFILE_TYPE ( USER_ID, PROFILE_TYPE_ID, PROFILE_TYPE_ENV_ID, IS_DELETED)
VALUES (@USER.$USERNAME, @PROFILE.KMMANAGEMENT, @ENV.Dflt, 'N');

INSERT INTO GTCC_MEMBEROFBLEND (AGENT_ID, BLEND_ID)
VALUES (@PERSON.$USERNAME, @BLEND.Email);
INSERT INTO EVA_ENTITY__ENTITLEMENT (ENTITLEMENT_ID, ENTITLEMENT_ENV_ID, ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, IS_DELETED, RELEASEID)
VALUES (@ENTLMNT.DCC0, @ENV.Dflt, @PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, 'N', -1);
INSERT INTO EVA_ENTITY__ENTITLEMENT (ENTITLEMENT_ID, ENTITLEMENT_ENV_ID, ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, IS_DELETED, RELEASEID)
VALUES (@ENTLMNT.DCCKMContentAgent, @ENV.Dflt, @PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, 'N', -1);
INSERT INTO EVA_ENTITY__ENTITLEMENT (ENTITLEMENT_ID, ENTITLEMENT_ENV_ID, ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, IS_DELETED, RELEASEID)
VALUES (@ENTLMNT.DCCKMFeedbackReviewer, @ENV.Dflt, @PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, 'N', -1);
INSERT INTO EVA_ENTITY__ENTITLEMENT (ENTITLEMENT_ID, ENTITLEMENT_ENV_ID, ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, IS_DELETED, RELEASEID)
VALUES (@ENTLMNT.DCCKMContentAuthor, @ENV.Dflt, @PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, 'N', -1);
INSERT INTO EVA_ENTITY__ENTITLEMENT (ENTITLEMENT_ID, ENTITLEMENT_ENV_ID, ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, IS_DELETED, RELEASEID)
VALUES (@ENTLMNT.ViewDCCTags, @ENV.Dflt, @PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, 'N', -1);
INSERT INTO EVA_ENTITY__ENTITLEMENT (ENTITLEMENT_ID, ENTITLEMENT_ENV_ID, ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, IS_DELETED, RELEASEID)
VALUES (@ENTLMNT.KMAuthor, @ENV.Dflt, @PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, 'N', -1);
INSERT INTO EVA_ENTITY__ENTITLEMENT (ENTITLEMENT_ID, ENTITLEMENT_ENV_ID, ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, IS_DELETED, RELEASEID)
VALUES (@ENTLMNT.RestoreWorkItem, @ENV.Dflt, @PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, 'N', -1);



INSERT INTO EVA_ENTITY_PROPERTY (ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, PROPERTY_NAME, PROPERTY_VALUE)
values (@PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, 'DEFAULT_EMAIL_FROM_ADDRESS', 'kirsty.davidson@dhl.com');




INSERT INTO CW_ROUTING_ENTITLEMENT(ENTITY_ID, ENTITY_ENV_ID, ENTITY_TYPE_ID, ENTITY_TYPE_ENV_ID, ENTITLEMENT_ID, ENTITLEMENT_ENV_ID, NAME, RELEASE_ID)
VALUES(@PERSON.$USERNAME, @ENV.Dflt, @ET.Agent, @ENV.Dflt, @ENTLMNT.QualityAssuranceRepresentative, @ENV.Dflt, 'QA', @RELEASE.ID);"





--TITTLE_ID




