#!/bin/bash

. xml/repository.sh

object_path=$1
is_create_test_subpackage=$2
test_path=$(unit_test_full_path $object_path $is_create_test_subpackage)

./commands/create-test.sh $object_path $test_path
