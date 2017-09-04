#!/bin/bash


find_first_difference_index(){
	A=$1
	B=$2
	RESULT=-1
	MAX_LENGTH=${#A}
	if [ ${#A} -lt ${#B} ]; then
		MAX_LENGTH=${#B}
	fi
	for i in $(seq 0 ${MAX_LENGTH})
	do
		CHAR_A=${A:i:1}
		CHAR_B=${B:i:1}

		if [[ "$CHAR_A" != "$CHAR_B" ]]; then
			RESULT=$i
			break
		fi
	done
	echo $RESULT
}
extract_substring_radio(){
	STRING=$1
	INDEX=$2
	RADIO=$3
	let DIAMETER=$RADIO*2+1
	let MIN_DEL=$INDEX-$RADIO
	if [ $MIN_DEL -lt 0 ]; then
		MIN_DEL=0
		DIAMETER=$INDEX+$RADIO+1
	fi
	echo "${STRING:MIN_DEL:DIAMETER}"
}
surround_char_at_index(){
	string_to_surround=$1
	index=$2
	if [ $index -gt -1 ]; then
		surrounded_char=[${string_to_surround:$index:1}]
		length=${#string_to_surround}
		echo ${string_to_surround:0:$index}$surrounded_char${string_to_surround:$index+1:$length-1}
	fi
	#echo $string_to_surround

}
extract_assert_message(){
	A=$1
	B=$2
	RADIO=$3
	INDEX=$(find_first_difference_index "$A" "$B")
	if [ $INDEX -gt -1 ]; then
		marked_a=$(surround_char_at_index "$A" $INDEX)
		marked_b=$(surround_char_at_index "$B" $INDEX)
		#as we surround char adds two characters at the first difference index, increment index and radio
		RELEVANT_A=$(extract_substring_radio "$marked_a" $((INDEX+1)) $((RADIO+1)))
		RELEVANT_B=$(extract_substring_radio "$marked_b" $((INDEX+1)) $((RADIO+1)))
		RESULT="Expected '...$RELEVANT_A...' but was '...$RELEVANT_B...'"
	else
		RESULT=""
	fi

	echo $RESULT
}
assert_equals(){
	EXPECTED=$1
	RESULT=$2
	SCENARIO=$3
	ERROR=$(extract_assert_message "$EXPECTED" "$RESULT" "50")
	if [[ "$ERROR" != "" ]]; then
		diferent_index=$(find_first_difference_index "$EXPECTED" "$RESULT")
		ERROR="Failed when running \'$SCENARIO\'.$ERROR"
		$T_fail "${ERROR} $'\n'Full message is, expected \"$EXPECTED\" $'\n' but was \"$RESULT\"$'\n' Diferent at index $diferent_index."

		die "an error has ocurred $'\n'" 
		
		return 1
	fi
	return 0
}
die() {
	local frame=0
	while caller $frame; do
		((frame++));
	done
	echo "$*"
	#exit 1
}

remove_all_white_spaces(){
	echo $1 | sed -e 's/ //g'
}
assert_equal_sql(){
	EXPECTED_SQL=$(remove_all_white_spaces "$1")
	ACTUAL_SQL=$(remove_all_white_spaces "$2")
	assert_equals "$EXPECTED_SQL" "$ACTUAL_SQL" "$3"
}
assert_equal_xml(){
	assert_equal_sql "$1" "$2"
}
