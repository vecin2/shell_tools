#!/bin/bash

. ./configuration.sh

REPO_PATH=$CORE_HOME/repository/default
TEMP_DIR=test_temp_installation
GIT_PRJ_NAME=EM_TestTools
mkdir $TEMP_DIR

if [ $? -ne 0 ]; then
	echo Clean the temp folder before continue
	exit 1
fi

echo hello
echo Moving TestTools modules to repository
cd $TEMP_DIR
git clone https://github.com/vecin2/EM_TestTools.git
#cp -r EM_TestTools/TestTools $REPO_PATH 
ln -svf EM_TestTools/TestTools $REPO_PATH 
#Add test patch
PATCH_NAME=AllowOverridingUnitTestName
PATCH_PATH=$CORE_HOME/patches/$PATCH_NAME.zip
echo checking if exist $PATCH_PATH
if [ -f "$PATCH_PATH" ]; then
	echo Patch has already being added!
else
	echo Adding test patch
	echo Zipping this folder: $GIT_PRJ_NAME/$PATCH_NAME
	cd $GIT_PRJ_NAME/$PATCH_NAME
	echo Zipping directory: $(pwd)
	zip -r  ../$PATCH_NAME .
	mv ../$PATCH_NAME.zip $CORE_HOME/patches

	echo Updating index withn META-INF
	cd $CORE_HOME/patches
	echo $PATCH_NAME >> META-INF/patch.index
	cd $SHELL_TOOLS_PATH
	./ccadmin.sh patch-core
fi

echo Removing temp folder
cd $SHELL_TOOLS_PATH
rm -rf $TEMP_DIR

