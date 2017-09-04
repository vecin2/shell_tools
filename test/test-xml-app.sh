
. test/libs/assert.sh
. ./configuration.sh
. ./xml/unit-test-builder.sh

assert_xml_equals(){
	EXPECTED_SQL=$(remove_all_white_spaces "$1")
	ACTUAL_SQL=$(remove_all_white_spaces "$2")
	assert_equals "$EXPECTED_SQL" "$ACTUAL_SQL" 
}
T_generate_unit_test_xml(){
	base_folder=$CORE_HOME/repository/default/shelltools
	expected_files_dir=$base_folder/Test/Xml/Utils/ExpectedTemplates
	expected_sql=$(cat $expected_files_dir/TestClassUnderTest.xml)
  
  result=$(unit_test_xml shelltools/Implementation/Xml/Utils/ClassUnderTest.xml) 	
  
	assert_equal_xml "$expected_sql" "$result"
}
#use path pass to unit_test_xml in previous test

T_create_unit_test_xml(){
	base_folder=$CORE_HOME/repository/default/shelltools/test/xml
	expected_files_dir=$base_folder/expectedTemplates
	expected_sql=$(cat shelltools/Test/Xml/UniteTests/TestClassUnderTest.xml)
  
  result=$(create_unit_test shelltools/Implementation/Xml/utils/ClassUnderTest.xml) 	
  
	assert_equal_xml "$expected_sql" "$result"
}
