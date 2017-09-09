
. test/libs/assert.sh
. ./configuration.sh
. ./xml/repository.sh

T_unit_test_path(){
	result=$(unit_test_path "ShellTools/Implementation/xml/Objects/ClassUnderTest")


	assert_equals "ShellTools/Test/xml/UnitTests" $result

}

T_unit_test_path(){
	result=$(unit_test_path "/ShellTools/Implementation/xml/Objects/ClassUnderTest")


	assert_equals "/ShellTools/Test/xml/UnitTests" $result

}
