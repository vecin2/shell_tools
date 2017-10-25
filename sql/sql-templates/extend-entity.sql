
INSERT INTO EVA_ENTITY_DEFINITION (ID, ENV_ID, NAME, TYPE_ID, TYPE_ENV_ID,  LOGICAL_OBJ_PATH, INTERFACE_PATH, IS_DELETED, ICON_PATH, INSTANCE_ICON_PATH , SUPER_ENTITY_DEFINITION, SUPER_ENTITY_DEFINITION_ENV_ID, RELEASE_ID, SUPPORTS_READONLY, IS_EXPANDABLE, IS_BASIC)  VALUES ($ENTITY_ID, @ENV.Dflt, '${ENTITY_NAME}', $ENTITY_TYPE, @ENV.Dflt, '$LOGICAL_OBJ_PATH', '$INTERFACE_PATH', 'N', '', '', NULL, NULL, @RELEASE.ID, 'Y', 'N', 'Y');
INSERT INTO EVA_ENTITY_DEFINITION_LOC(ID, ENV_ID, LOCALE, DISPLAY_NAME, DESCRIPTION, RELEASE_ID) VALUES
($ENTITY_ID, @ENV.Dflt, 'en-GB', '$ENTITY_DISP_NAME', '$ENTITY_DISP_NAME',@RELEASE.ID);

INSERT INTO EVA_CATEGORY_ENTRY (CATEGORY_ID, CATEGORY_ENV_ID, ENTITY_ID, ENTITY_ENV_ID) VALUES (@EC.SystemGeneral, @ENV.Dflt, ${ENTITY_ID}, @ENV.Dflt);


UPDATE EVA_ENTITY_DEFINITION SET (LOGICAL_OBJ_PATH, INTERFACE_PATH, SUPER_ENTITY_DEFINITION, SUPER_ENTITY_DEFINITION_ENV_ID) = ('$EXT_LOGICAL_OBJ_PATH', '$EXT_INTERFACE_PATH', $ENTITY_ID, @ENV.Dflt) WHERE NAME = '$ENTITY_NAME_TO_EXTEND' AND ENV_ID = @ENV.Dflt and RELEASE_ID = @RELEASE.ID;