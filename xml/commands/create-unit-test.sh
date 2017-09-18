#!/bin/bash

. xml/unit-test-builder.sh
. xml/repository.sh
. configuration.sh

add_square_brackets(){
	result=$(echo "$1" |  sed 's/DOCTYPE ObjectDefinition/DOCTYPE ObjectDefinition []/')
	echo "$result"
}	

print_to_file(){
	echo "$1" > $2
	formatted=$(xmlstarlet fo -R $2)
	formatted=$(add_square_brackets "$formatted")
	echo "$formatted" > $2
}
object_path=$1
is_create_test_subpackage=$2
object_name=${object_path##*/}
unit_test_xml $object_path
content="$xml"
test_path=$(unit_test_full_path $object_path $is_create_test_subpackage)

if [ ! -d $test_path ]; then 
	echo Creating folder:  $test_path
	mkdir -p $test_path
fi

target_file=$test_path/Test$object_name.xml
print_to_file "$content" $target_file
echo Test Created: $target_file

