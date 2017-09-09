#!/bin/bash

. xml/unit-test-builder.sh
. xml/repository.sh
. configuration.sh
object_path=$1
object_name=${object_path##*/}
content=$(unit_test_xml $1)
test_path=$(unit_test_path $1)
repo_path=${CORE_HOME}repository/default

echo object path: $object_path
test_path=$repo_path/$test_path
full_test_path=$test_path/Test$object_name.xml

echo creating test under $test_path
mkdir -p $test_path

echo "$content" > $full_test_path 
