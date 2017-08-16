
. test/libs/assert.sh
. ./configuration.sh
. ./xml/unit-test-builder.sh

assert_xml_equals(){
	EXPECTED_SQL=$(remove_all_white_spaces "$1")
	ACTUAL_SQL=$(remove_all_white_spaces "$2")
	assert_equals "$EXPECTED_SQL" "$ACTUAL_SQL" 
}
T_generate_unit_test_xml(){
	base_folder=$CORE_HOME/repository/default/shelltools/test/xml
	expected_files_dir=$base_folder/expectedTemplates
	expected_sql=$(cat $expected_files_dir/UnitTestCreatedFromObject.xml)
  
  result=$(unit_test_xml shelltools/test/xml/utils/ClassUnderTest.xml) 	
  
	assert_equal_xml "$expected_sql" "$result"
}
