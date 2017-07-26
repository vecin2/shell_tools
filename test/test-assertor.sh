#!/bin/bash

. test/libs/assert.sh

T_find_text_around_difference(){
	test_find_first_diffence_index "hola Ramon" "holas Ramon" 4 "difference middle"
}
T_find_text_around_difference_end_B(){
	test_find_first_diffence_index "hola Ramo" "hola Ramon" 9 "difference end B"
}
T_find_text_around_difference_end_A(){
	test_find_first_diffence_index "hola Ramon" "hola Ramo" 9 "difference end A"
}
T_find_text_around_difference_empty_A(){
	test_find_first_diffence_index "" "hola Ramo" 0 "difference empty A"
}
T_find_text_around_difference_empty_B(){
	test_find_first_diffence_index "hola Ramo" "" 0 "difference empty B"
}
test_find_first_diffence_index(){
	RESULT=$(find_first_difference_index "$1" "$2")
	EXPECTED="$3"
	SCENARIO=$4
	assert_scenario $EXPECTED $RESULT $SCENARI0
}
assert_scenario(){
	EXPECTED=$1
	RESULT=$2
	SCENARI0=$3
	if [[ "$RESULT" != "$EXPECTED" ]]; then
		$T_fail "Failed when running \'$SCENARIO\'. We were expecting \'$EXPECTED\' but the the result was \'$RESULT\'"
		return 1
	fi
	return 0
}
T_extract_substring_radio_1(){
	test_extract_substring_radio "David" "3" "1" "vid" "testing radio of 1"
}
T_extract_substring_radio_2(){
	test_extract_substring_radio "David" "2" "2" "David" "testing radio of 2"
}
T_extract_substring_radio_3(){
	test_extract_substring_radio "Fernando" "3" "3" "Fernand" "testing radio of 3"
}
T_extract_substring_radio_including_other_words(){
	test_extract_substring_radio "Fernando Sanchez" "7" "3" "ando Sa" "testing radio including other words"
}
T_extract_substring_radio_from_0(){
	test_extract_substring_radio "Fernando Sanchez" "0" "3" "Fern" "testing radio from 0"
}
T_extract_substring_radio_from_one_and_radio_3(){
	test_extract_substring_radio "Fernando Sanchez" "1" "3" "Ferna" "testing radio including from 1 and radio 2"
}
T_extract_substring_radio_from_last_and_radio_3(){
	test_extract_substring_radio "David Garcia" "11" "3" "rcia" "testing radio including from last and radio 3"
}
T_extract_substring_radio_from_before_last_and_radio_3(){
	test_extract_substring_radio "David Garcia" "10" "3" "arcia" "testing radio including from before last and radio 3"
}
test_extract_substring_radio(){
	RESULT=$(extract_substring_radio "$1" "$2" "$3")
	EXPECTED="$4"
	SCENARIO=$5
	assert_scenario "$EXPECTED" "$RESULT" "$SCENARI0"
}
T_extract_assert_message_in_middle(){
	test_extract_assert_message "This is just a comment" "This i just a comment" "4" "Expected '...is is jus...' but was '...is i just...'"
}
T_extract_assert_message_no_difference(){
	test_extract_assert_message "This is just a comment" "This is just a comment" "4" ""
}
T_extract_assert_message_diff_no_alpha(){
	test_extract_assert_message "-This is just a comment" "--This is just a comment" "4" "Expected '...-This ...' but was '...--This...'"
}
test_extract_assert_message(){
	RESULT=$(extract_assert_message "$1" "$2" $3)
	EXPECTED=$4
	assert_scenario "$EXPECTED" "$RESULT" "$SCENARI0"
}
#Uncomment this test to how assert build the error message
#T_assert_equals(){
#	assert_equals "Hi there Mark" "Hi there Park" "Testing assert"
#}
