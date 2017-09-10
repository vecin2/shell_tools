sanitise_first_char_separator(){
  result=$1	
	if [[ $result == /* ]]; then
		result=${result#/}
	fi
	echo $result
}
