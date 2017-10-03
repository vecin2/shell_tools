
. test/libs/assert.sh
. ./configuration.sh
. ./xml/unit-test-builder.sh
. ./xml/repository.sh

assert_xml_equals(){
	EXPECTED_SQL=$(remove_all_white_spaces "$1")
	ACTUAL_SQL=$(remove_all_white_spaces "$2")
	assert_equals "$EXPECTED_SQL" "$ACTUAL_SQL" 
}
T_generate_unit_test_xml(){
	base_folder=$CORE_HOME/repository/default/shelltools
	expected_files_dir=$base_folder/Test/Xml/Utils/ExpectedTemplates
	expected_sql=$(cat $expected_files_dir/TestClassUnderTest.xml)
  
	result=$(unit_test_xml "shelltools/Implementation/Xml/Utils/ClassUnderTest.xml")
	
  
	assert_equal_xml "$expected_sql" "$result"
}

T_unit_test_path_start_with_no_delimiter(){
	result=$(unit_test_path "ShellTools/Implementation/xml/Objects/ClassUnderTest" true)

	assert_equals "ShellTools/Test/xml/UnitTests" $result
}

T_unit_test_path_start_with_delimiter(){
	result=$(unit_test_path "/ShellTools/Implementation/xml/Objects/ClassUnderTest" true)

	assert_equals "/ShellTools/Test/xml/UnitTests" $result
}

T_unit_test_path(){
	result=$(unit_test_path "/ShellTools/Implementation/xml/Objects/ClassUnderTest" false)
	echo result is $result

	assert_equals "/ShellTools/Test/UnitTests" $result

}
