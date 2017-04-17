INSERT INTO EVA_TAG (ID,ENV_ID,RELEASE_ID,TAGSET_ID,TAGSET_ENV_ID,TAGSET_RELEASE_ID,PARENT_TAG,PARENT_TAG_ENV_ID,PARENT_TAG_RELEASE_ID,PREVIOUS_TAG,PREVIOUS_TAG_ENV_ID,PREVIOUS_TAG_RELEASE_ID,NAME,IS_SYSTEM,IS_DELETED,IS_RETIRED,EXPAND_DIRECTION,CREATED_DATE,LAST_MODIFIED_DATE,LEFT_VAL,RIGHT_VAL,DEPTH_VAL,DISPLAY_ORDER,SYSTEM_CODE,TENANT_ID) VALUES (
@TAG.${TAG_ID},  -- ID
@ENV.Dflt,  -- ENV_ID
@RELEASE.ID,  -- RELEASE_ID
@TAG.$TAGSET_ID,  -- TAGSET_ID
@ENV.Dflt,  -- TAGSET_ENV_ID
@RELEASE.ID,  -- TAGSET_RELEASE_ID
$PARENT_TAG,  -- PARENT_TAG
$PARENT_TAG_ENV_ID,  -- PARENT_TAG_ENV_ID
$PARENT_TAG_RELEASE_ID,  -- PARENT_TAG_RELEASE_ID
$PREVIOUS_TAG,  -- PREVIOUS_TAG
$PREVIOUS_TAG_ENV_ID,  -- PREVIOUS_TAG_ENV_ID
$PREVIOUS_TAG_RELEASE_ID,  -- PREVIOUS_TAG_RELEASE_ID
'$SYSTEM_CODE',  -- NAME
'$IS_SYSTEM',  -- IS_SYSTEM
'N',  -- IS_DELETED
'N',  -- IS_RETIRED
'$EXPAND_DIRECTION',  -- EXPAND_DIRECTION
TO_DATE('$DATE 17:01:40 PM','MM/DD/YYYY HH:MI:SS AM'),  -- CREATED_DATE
TO_DATE('$DATE 17:01:40 PM','MM/DD/YYYY HH:MI:SS AM'),  -- LAST_MODIFIED_DATE
$LEFT_VAL,  -- LEFT_VAL
$RIGHT_VAL,  -- RIGHT_VAL
$DEPTH_VAL,  -- DEPTH_VAL
$DISPLAY_ORDER, -- DISPLAY_ORDER
'$SYSTEM_CODE', -- SYSTEM_CODE
'default' -- TENANT_ID
);
INSERT INTO EVA_TAG_LOC (ID, ENV_ID, RELEASE_ID, LOCALE, DESCRIPTION, REPORTING_LABEL,TENANT_ID) VALUES (
@TAG.$TAG_ID,  -- ID
@ENV.Dflt,  -- ENV_ID
@RELEASE.ID,  -- RELEASE_ID
'en-GB',  -- LOCALE
'$DISPLAY_NAME',  -- DESCRIPTION
NULL, -- REPORTING_LABEL
'default' -- TENANT_ID
);
INSERT INTO EVA_TAG_DISPLAY_NAME (ID, ENV_ID, RELEASE_ID, DISPLAY_NAME_TYPE_ID, DISPLAY_NAME_TYPE_ENV_ID, DISPLAY_NAME_TYPE_RELEASE_ID,TENANT_ID) VALUES (
@TAG.$TAG_ID,  -- ID
@ENV.Dflt,  -- ENV_ID
@RELEASE.ID,  -- RELEASE_ID
@TDNT.ShortNameType,  -- DISPLAY_NAME_TYPE_ID
@ENV.Dflt,  -- DISPLAY_NAME_TYPE_ENV_ID
@RELEASE.ID, -- DISPLAY_NAME_TYPE_RELEASE_ID
'default' -- TENANT_ID
);
INSERT INTO EVA_TAG_DISPLAY_NAME_LOC (ID, ENV_ID, RELEASE_ID, LOCALE, DISPLAY_NAME, DISPLAY_NAME_TYPE_ID, DISPLAY_NAME_TYPE_ENV_ID, DISPLAY_NAME_TYPE_RELEASE_ID,TENANT_ID) VALUES (
@TAG.$TAG_ID,  -- ID
@ENV.Dflt,  -- ENV_ID
@RELEASE.ID,  -- RELEASE_ID
'en-GB',  -- LOCALE
'$DISPLAY_NAME',  -- DISPLAY_NAME
@TDNT.ShortNameType,  -- DISPLAY_NAME_TYPE_ID
@ENV.Dflt,  -- DISPLAY_NAME_TYPE_ENV_ID
@RELEASE.ID, -- DISPLAY_NAME_TYPE_RELEASE_ID
'default' -- TENANT_ID
);
