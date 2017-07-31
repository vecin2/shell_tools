. test/libs/assert.sh

T_rewire_verb(){
	MODULE_PATH="../modules/test/test-modules/test-rewire-verb"	
	FILE_PATH=$MODULE_PATH/tableData.sql
	
	TOPTION="ee"
	TCOMMENT="this is a comment"
	TENTITY_TO_EXTEND="CustomerED"
	TINTERFACE_PATH="CoreEntites.API.Interfaces.EICustomer"
	TLOGICAL_OBJ_PATH="CoreEntites.Implementation.Customer.Customer"
	TNEW_ENTITY_ID="SPENCustomer"
	TNEW_INTERFACE_PATH="SPENCustomer.API.EISPENCustomer"
	TNEW_LOGICAL_OBJ_PATH="SPENCustomer.Implementation.Customer.Customer"
	TOPTION2="x"
	EXPECTED_SQL="--thisisacommentINSERTINTOEVA_ENTITY_DEFINITION(ID,ENV_ID,NAME,TYPE_ID,TYPE_ENV_ID,LOGICAL_OBJ_PATH,INTERFACE_PATH,IS_DELETED,ICON_PATH,INSTANCE_ICON_PATH,SUPER_ENTITY_DEFINITION,SUPER_ENTITY_DEFINITION_ENV_ID,RELEASE_ID,SUPPORTS_READONLY,IS_EXPANDABLE,IS_BASIC)VALUES(@ED.SPENCustomer,@ENV.Dflt,'BaseCustomerED',@ET.SPENCustomer,@ENV.Dflt,'CoreEntites.Implementation.Customer.Customer','CoreEntites.API.Interfaces.EICustomer','N','','',NULL,NULL,@RELEASE.ID,'Y','N','Y');INSERTINTOEVA_ENTITY_DEFINITION_LOC(ID,ENV_ID,LOCALE,DISPLAY_NAME,DESCRIPTION,RELEASE_ID)VALUES(@ED.SPENCustomer,@ENV.Dflt,'en-GB','SPENCustomer','SPENCustomer',@RELEASE.ID);INSERTINTOEVA_CATEGORY_ENTRY(CATEGORY_ID,CATEGORY_ENV_ID,ENTITY_ID,ENTITY_ENV_ID)VALUES(@EC.SystemGeneral,@ENV.Dflt,@ED.SPENCustomer,@ENV.Dflt);UPDATEEVA_ENTITY_DEFINITIONSET(LOGICAL_OBJ_PATH,INTERFACE_PATH,SUPER_ENTITY_DEFINITION,SUPER_ENTITY_DEFINITION_ENV_ID)=('SPENCustomer.Implementation.Customer.Customer','SPENCustomer.API.EISPENCustomer',@ED.SPENCustomer,@ENV.Dflt)WHERENAME='CustomerED'ANDENV_ID=@ENV.DfltandRELEASE_ID=@RELEASE.ID;"
	
	rm $FILE_PATH
	echo -e "$TOPTION
					 $TCOMMENT
					 $TENTITY_TO_EXTEND
					 $TINTERFACE_PATH
					 $TLOGICAL_OBJ_PATH
					 $TNEW_ENTITY_ID
					 $TNEW_INTERFACE_PATH
					 $TNEW_LOGICAL_OBJ_PATH
					 $TOPTION2" | ./sql-app.sh $MODULE_PATH 123 > /dev/null

	ACTUAL_SQL=$(cat $FILE_PATH)

	assert_sql_equals "$EXPECTED_SQL" "$ACTUAL_SQL" "Testing add persistable entity"
}

T_add_persistable_entity(){
	MODULE_PATH="../modules/test/test-modules/test-add-persistable-entity"	
	FILE_PATH=$MODULE_PATH/tableData.sql
	
	TOPTION="ape"
	TCOMMENT="this is a comment"
	TMY_ENTITY="MyEntity"
	TLOGICAL_OBJ_PATH="Objects/MyEntity"
	TINTERFACE_PATH="API/EIMyEntity"
	TOPTION2="x"
	EXPECTED_SQL="--this is a comment
	INSERT INTO EVA_ENTITY_DEFINITION (ID, ENV_ID, NAME, TYPE_ID, TYPE_ENV_ID, LOGICAL_OBJ_PATH, INTERFACE_PATH, IS_DELETED, IS_BASIC, ICON_PATH, INSTANCE_ICON_PATH, SUPER_ENTITY_DEFINITION, SUPER_ENTITY_DEFINITION_ENV_ID, RELEASE_ID, PERSISTENCE_MANAGER, SUPPORTS_READONLY) VALUES
	(@ED.MyEntity, @ENV.Dflt, 'MyEntityED', @ET.MyEntity, @ENV.Dflt, 'Objects/MyEntity', 'API/EIMyEntity', 'N', 'N',NULL, NULL, @ED.PersistableEntity, @ENV.Dflt, @RELEASE.ID, NULL, 'Y');
	INSERT INTO EVA_ENTITY_DEFINITION_LOC(ID, ENV_ID, LOCALE, DISPLAY_NAME, DESCRIPTION, RELEASE_ID) VALUES
	(@ED.MyEntity, @ENV.Dflt, 'en-GB', 'MyEntity', 'MyEntity',@RELEASE.ID);
	INSERT INTO EVA_CATEGORY_ENTRY (CATEGORY_ID, CATEGORY_ENV_ID, ENTITY_ID, ENTITY_ENV_ID) VALUES (@EC.SystemGeneral, @ENV.Dflt, @ED.MyEntity, @ENV.Dflt);"
	
	rm $FILE_PATH
	echo -e "$TOPTION
					 $TCOMMENT
					 $TMY_ENTITY
					 $TLOGICAL_OBJ_PATH
					 $TINTERFACE_PATH
					 $TOPTION2" | ./sql-app.sh $MODULE_PATH 123 > /dev/null 

	ACTUAL_SQL=$(cat $FILE_PATH)

	assert_sql_equals "$EXPECTED_SQL" "$ACTUAL_SQL" "Testing add persistable entity"
}

remove_all_white_spaces(){
	echo $1 | sed -e 's/ //g'
}
assert_sql_equals(){
	EXPECTED_SQL=$(remove_all_white_spaces "$1")
	ACTUAL_SQL=$(remove_all_white_spaces "$2")
	assert_equals "$EXPECTED_SQL" "$ACTUAL_SQL" "$3"
}
