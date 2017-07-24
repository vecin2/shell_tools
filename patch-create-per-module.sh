#!/bin/bash

. ./configuration.sh

if [ $# -ne 2 ]; then
	echo Please enter two parameters: patch.name relative.module.path
	exit 1
fi
PATCH_NAME=$1
RELATIVE_MODULE_PATH=$2
cd $RELATIVE_MODULE_PATH
MODULE_PATH=$(pwd)
MODULE_NAME=$(basename $MODULE_PATH)
 
MODULE_DIR=$(dirname $MODULE_PATH)
BASE_TEMP_PATH=$CORE_HOME/patches/tempPatch/
TEMP_PATH=$BASE_TEMP_PATH/$PATCH_NAME
PATCH_REPO_PATH=$TEMP_PATH/core/repository/default/

echo "MODULE_PATH is $MODULE_PATH, MODULE_DIR is $MODULE_DIR and MODULE_NAME is $MODULE_NAME"
mkdir -p $PATCH_REPO_PATH
mkdir $BASE_TEMP_PATH/META-INF
echo $PATCH_NAME >  $BASE_TEMP_PATH/META-INF/patch.index
echo "Please describe the patch within this README.txt file which will be included within the patch" > $BASE_TEMP_PATH/README.txt
vi $BASE_TEMP_PATH/README.txt 

cd $MODULE_DIR
FILES=$(svn st $MODULE_NAME | grep -v .properties | awk '{print $2}')

echo "$FILES"
echo moving files to $TEMP_PATH
cp --parents $(echo $FILES)  $PATCH_REPO_PATH
cd $BASE_TEMP_PATH

echo checkin if ../patches/${PATCH_NAME}.zip exists...
if [ -f ../${PATCH_NAME}.zip ]; then
	echo zip file already exist, removing existing one
	rm ../${PATCH_NAME}.zip
else
	echo Updating index within META-INF
	echo $PATCH_NAME >> $CORE_HOME/patches/META-INF/patch.index
fi
echo Zipping current directory $(pwd)
zip -r ../$PATCH_NAME.zip . > /dev/null  2>&1

rm -r $BASE_TEMP_PATH

unzip -l  ../$PATCH_NAME.zip

read -p "Do you want to delete the changes and apply the patch to make sure is working correctly? (y/n)" IS_APPLY_PATCH

echo option selected is $IS_APPLY_PATCH
if [ "${IS_APPLY_PATCH^^}" == "Y" ]; then
	echo "removing changes and applying patch"
	cd $MODULE_DIR
	svn revert -R $MODULE_NAME 
	cd $SHELL_TOOLS_PATH
	./ccadmin.sh patch-core
	echo "Running svn status in module to check patch has override files correctly:"
	svn st $RELATIVE_MODULE_PATH
fi
