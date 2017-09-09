#!/bash/bin

. ./lib/string_manipulation.sh

unit_test_path(){
	obj_path=$1
	module=$(echo $obj_path | awk -F "/Implementation" '{print $1}')
	counter=0
	imp_subpackage=$(imp_subpackage $obj_path)
	result=$module/Test/$imp_subpackage/UnitTests
	echo $result
}
imp_subpackage(){
	index_of_implementation $1
	implementation_index=$?
	let "cut_index=implementation_index +2"
	echo $obj_path | cut -d '/' -f$cut_index
}
index_of_implementation(){
	obj_path=$1
	obj_path=$(sanitise_first_char_separator $obj_path)
	for folder in ${obj_path//\// }
	do
		if [ "$folder" == "Implementation" ]; then
			return $counter
		fi
		let "counter++"
	done
}
