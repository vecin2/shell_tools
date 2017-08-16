#!/bin/bash

unit_test_xml(){
	class_under_test_name=$1
	result=$(cat xml/templates/UnitTestCreatedFromObject.xml)
	#set_name Test$class_under_test_name
	echo $result
}
