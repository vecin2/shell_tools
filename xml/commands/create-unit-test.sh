#!/bin/bash

. xml/unit-test-builder.sh
. xml/repository.sh
. configuration.sh
object_path=$1
is_create_test_subpackage=$2
object_name=${object_path##*/}
content=$(unit_test_xml $object_path)
test_path=$(unit_test_full_path $object_path $is_create_test_subpackage)

if [ ! -d $test_path ]; then 
	echo Creating folder:  $test_path
	mkdir -p $test_path
fi

target_file=$test_path/Test$object_name
echo "$content" > $target_file

echo Test Created: $target_file
