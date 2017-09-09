sanitise_first_char_separator(){
  obj_path=$1	
	if [[ $obj_path == /* ]]; then
		result=${obj_path#/}
	fi
	echo $result
}
