#!/bin/bash


. xml/ei-builder.sh
. lib/file-printer.sh

#ask for parameters

object_path=$1
is_create_test_subpackage=$2
content=$(unit_test_xml $object_path)

target_file=$2

print_xml_to_file "$content" $target_file
echo Test Created: $target_file


