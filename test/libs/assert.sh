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
extract_assert_message(){
	A=$1
	B=$2
	RADIO=$3
	INDEX=$(find_first_difference_index "$A" "$B")
	if [ $INDEX -gt -1 ]; then
		RELEVANT_A=$(extract_substring_radio "$A" $INDEX $RADIO)
		RELEVANT_B=$(extract_substring_radio "$B" $INDEX $RADIO)
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
		ERROR="Failed when running \'$SCENARIO\'.$ERROR"
		$T_fail "${ERROR}"
		return 1
	fi
	return 0
}
