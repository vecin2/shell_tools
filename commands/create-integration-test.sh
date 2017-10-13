#!/bin/bash

. xml/repository.sh

object_path=$1
is_create_test_subpackage=$2
test_path=$(integration_test_full_path $object_path $is_create_test_subpackage)
echo test path is $test_path

./commands/create-test.sh $object_path $test_path
