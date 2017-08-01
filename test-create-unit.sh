#!/bin/bash

. ./configuration.sh

if [ "$#" -ne 1 ]; then
	echo Usage Class.under.test.repository.path
	exit
fi

#find implementation folder /SPENAutoContactHistory/Implementation/ContactHistory/Objects/SPENContactHistory
OBJ_PATH=$1
MODULE=$(echo $OBJ_PATH | awk -F "/Implementation" '{print $1}')
echo Module  is $MODULE
REPO_DIR=$CORE_HOME/repository/default
UNIT_TEST_FOLDER=$REPO_DIR/$MODULE/Test/UnitTests
XML_TEMPLATES_DIR=$SHELL_TOOLS_PATH/xml/templates
OBJ_TEMPLATE_DIR=$XML_TEMPLATES_DIR/UnitTest.xml

echo Creating directory $UNIT_TEST_FOLDER
mkdir -p $UNIT_TEST_FOLDER
echo copying from $OBJ_TEMPLATE_DIR to $UNIT_TEST_FOLDER
cp  $OBJ_TEMPLATE_DIR $UNIT_TEST_FOLDER

set_Name TestSPENContactHistory

parse_xml_template UnitTest.xml

create_file "$PARSED_XML" $UNIT_TEST_FOLDER

#building file
create_enconding
create_object_definition
package_entry=create_package_entry
add_import $OBJ_PATH 
add_import $ktest_case_path
set_object_definition "TestSPENContactHistory"
set_superclass "KTestCase"
build_class
#create folder at implementation level
#create folder at api level
#create without passing /at teh beginning



