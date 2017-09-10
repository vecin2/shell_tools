
. test/libs/assert.sh
. ./configuration.sh
. ./xml/repository.sh

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

#T_unit_full_test_path(){
#
#	result=$(unit_full_test_path "/ShellTools/Implementation/xml/Objects/ClassUnderTest" false)
#
#
#	assert_equals "${CORE_HOME}repository/default/ShellTools/Test/UnitTests" $result
#
#}
