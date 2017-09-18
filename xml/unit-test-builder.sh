#!/bin/bash
. ./xml/object-builder.sh

xml_template_dir=xml/templates
object_template=$xml_template_dir/Object.xml  

unit_test_xml(){
	class_under_test_path=$1
	#test_class_name=$(generate_test_name class_under_test_path)
	#xml=$(cat xml/templates/Object.xml)
	xml=$(cat xmlstartlet/testEmpty.xml)
	import_package "/TestTools/TestUnit/Objects/KTestCase"
	import_package "/shelltools/Implementation/Xml/Utils/ClassUnderTest"
	xml_object_definition
	#set_name $test_class_name
	#import_package "/shelltools/Implementation/Xml/Utils/ClassUnderTest"
	inherit_from "KTestCase"
	add_field $class_under_test_type "classUnderTest"
	#inherit_from /TestTools/TestUnit/Objects/KTestCase 
	#add_attribute $class_under_test
	#add a test method belongs to other method (create_unit_test)
	#add_fail_test_method "test$class_under_test_name"
	#if not exist create test runner
	#run unit test

	#echo $xml
}
generate_test_name(){
	class_under_test_file=${class_under_test_path##*/}
	class_under_test_name=${class_under_test_file%.*}
	echo Test$class_under_test_name
}


#add import declaration with name ktestcase
#xmlstarlet ed -s /PackageEntry -t elem -n ImportDeclaration -v "" -i /PackageEntry/ImportDeclaration -t attr -n name -v KTestCase Object.xml | xmlstarlet ed -s /PackageEntry/ImportDeclaration -t elem -n PackageSpecifier -v "" | xmlstarlet ed -s /PackageEntry/ImportDeclaration/PackageSpecifier -t elem -n PackageName -v ""
