#!/bash/bin

. ./lib/string_manipulation.sh
. ./configuration.sh


unit_test_full_path(){
	object_path=$1
	is_create_subtest_package=$2
	repo_path=$(unit_test_path $object_path $is_create_subtest_package)
	echo ${CORE_HOME}repository/default/$repo_path
}
unit_test_path(){
	obj_path=$1
	create_test_subpackage=$2

	test_subpackage=$(extract_test_subpackage $obj_path $create_test_subpackage)
	result=$(extract_module)/Test/${test_subpackage}UnitTests

  echo $result
}

extract_module(){
	echo $obj_path | awk -F "/Implementation" '{print $1}'
}

extract_test_subpackage(){
	if $2 ; then
		test_subpackage=$(imp_subpackage $1)/
	else
		test_subpackage=""
	fi
	echo $test_subpackage
}

imp_subpackage(){
	extract_imp_cut_index $1
	imp_index=$?
	if [ $imp_index -ne 100 ]; then
		echo $(echo $obj_path | cut -d '/' -f$((imp_index+1))) 
	fi
}

extract_imp_cut_index(){
	obj_path=$(sanitise_first_char_separator $1)
	folder=$(echo $obj_path | cut -d '/' -f1)
	counter=2
	while [ -n "$folder" ]; do
		folder=$(echo $obj_path | cut -d '/' -f$counter)
		if [ "$folder" == "Implementation" ]; then
			return $counter
		fi
		counter=$((counter+1))
	done
	return 100
}
