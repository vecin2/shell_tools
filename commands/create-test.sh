#!/bin/bash

. xml/unit-test-builder.sh
. xml/repository.sh
. lib/file-printer.sh

object_path=$1
test_path=$2
content=$(unit_test_xml $object_path)

print_xml_to_file "$content" $test_path
echo Test Created: $test_path

