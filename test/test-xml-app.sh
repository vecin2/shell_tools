
. test/libs/assert.sh

T_create_unit_test(){
	MODULE_PATH="../modules/test/test-modules/test-rewire-verb"	
	FILE_PATH=$MODULE_PATH/tableData.sql
	
	local toption="cut"
	local tclass_under_test_path="/SPENContactHistory/Implementation/Objects/SPENContactHistory"
	TENTITY_TO_EXTEND="CustomerED"

EXPECTED_XML=$(cat test/expected-xml-files/expected-unit-test.xml)
	echo -e "$toption
					 $tclass_under_test_path
					 $TOPTION2" | ./xml-parser.sh > /dev/null

	ACTUAL_SQL=$PARSED_XML

	assert_xml_equals "$EXPECTED_SQL" "$PARSED_XML" 

}
assert_xml_equals(){
	EXPECTED_SQL=$(remove_all_white_spaces "$1")
	ACTUAL_SQL=$(remove_all_white_spaces "$2")
	assert_equals "$EXPECTED_SQL" "$ACTUAL_SQL" 
}
