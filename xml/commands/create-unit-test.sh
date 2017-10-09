#!/bin/bash

. xml/unit-test-builder.sh
. xml/repository.sh
. lib/file-printer.sh

object_path=$1
is_create_test_subpackage=$2
if [ -z "$is_create_test_subpackage" ]; then
	is_create_test_subpackage=false
	echo Defaulting value to not create test subpackage
fi
content=$(unit_test_xml $object_path)
target_file=$(unit_test_full_path $object_path $is_create_test_subpackage)

print_xml_to_file "$content" $target_file
echo Test Created: $target_file

