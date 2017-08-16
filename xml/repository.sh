#!/bash/bin

unit_test_path(){
	obj_path=$1
	module=$(echo $obj_path | awk -F "/Implementation" '{print $1}')
	result=$module/Test/xml/UnitTests
	echo $result
}
