#!/bin/bash
. ./xml/object-builder.sh

xml_template_dir=xml/templates
object_template=$xml_template_dir/Object.xml  

unit_test_xml(){
	class_under_test_path=$1
	test_class_name=$(generate_test_name $class_under_test_path)
	#xml=$(cat xml/templates/Object.xml)
	xml=$(cat xmlstartlet/testEmpty.xml)
	xml=$(cat xml/templates/EmptyObjectDefinition.xml)
	import_package "/TestTools/TestUnit/Objects/KTestCase"
	import_package $(remove_extension $class_under_test_path)
	xml_object_definition $test_class_name
	#set_name $test_class_name
	#import_package "/shelltools/Implementation/Xml/Utils/ClassUnderTest"
	inherit_from "KTestCase"
	add_field $(extract_type_name $class_under_test_path) "classUnderTest"
	add_square_brackets_xml
	#inherit_from /TestTools/TestUnit/Objects/KTestCase 
	#add_attribute $class_under_test
	#add a test method belongs to other method (create_unit_test)
	#add_fail_test_method "test$class_under_test_name"
	#if not exist create test runner
	#run unit test

	#echo $xml
}
remove_extension(){
	file_path=$1
	echo ${file_path%.*}
}
extract_type_name(){
	object_path=$1
	class_under_test_file=${object_path##*/}
	echo $(remove_extension $class_under_test_file)
}
generate_test_name(){
	echo Test$(extract_type_name $1)
}


