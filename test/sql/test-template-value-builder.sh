. ./test/libs/assert.sh
T_test_read_value(){
	. ./sql/template_value_builder.sh
	read_value "Please enter name" "name" "David"

	assert_equals "David" $name


}
