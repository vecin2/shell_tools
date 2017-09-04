#!/bin/bash
. ./xml/object-builder.sh

xml_template_dir=xml/templates
object_template=$xml_template_dir/Object.xml  
unit_test_xml(){
	class_under_test_path=$1
	class_under_test_file=${class_under_test_path##*/}
	class_under_test_name=${class_under_test_file%.*}
	xml=$(cat xml/templates/Object.xml)
	set_name "Test$class_under_test_name"
	import_package /TestTools/TestUnit/Objects/KTestCase
	inherit_from "KTestCase"
	#import_package $class_under_test
	#inherit_from /TestTools/TestUnit/Objects/KTestCase 
	#add_attribute $class_under_test
	#add a test method belongs to other method (create_unit_test)
	#add_fail_test_method "test$class_under_test_name"
	#if not exist create test runner
	#run unit test
	add_square_brackets

	echo $xml
}



#add import declaration with name ktestcase
#xmlstarlet ed -s /PackageEntry -t elem -n ImportDeclaration -v "" -i /PackageEntry/ImportDeclaration -t attr -n name -v KTestCase Object.xml | xmlstarlet ed -s /PackageEntry/ImportDeclaration -t elem -n PackageSpecifier -v "" | xmlstarlet ed -s /PackageEntry/ImportDeclaration/PackageSpecifier -t elem -n PackageName -v ""
