#!/bin/bash

. ./configuration.sh

PATCH_NAME=$1
BASE_TEMP_PATH=$CORE_HOME/patches/tempPatch/
TEMP_PATH=$BASE_TEMP_PATH/$PATCH_NAME
PATCH_REPO_PATH=$TEMP_PATH/core/repository/default/

mkdir -p $PATCH_REPO_PATH
mkdir $BASE_TEMP_PATH/META-INF
echo $PATCH_NAME >  $BASE_TEMP_PATH/META-INF/patch.index

cd ../repository/default

FILES=$(svn st AddCoreChannelsReportingFacts/ AddCoreW* CoreChannels/Test* | awk '{print $2}')
echo "$FILES"
echo moving files to $TEMP_PATH
cp --parents $(svn st AddCoreChannelsReportingFacts/ AddCoreW* CoreChannels/Test* | awk '{print $2}')  $PATCH_REPO_PATH
cd $BASE_TEMP_PATH

echo checkin if ../patches/${PATCH_NAME}.zip exists...
if [ -f ../${PATCH_NAME}.zip ]; then
	echo zip file already exist, removing existing one
	rm ../${PATCH_NAME}.zip
fi

zip -r ../$PATCH_NAME.zip . > /dev/null  2>&1

rm -r $BASE_TEMP_PATH

echo Updating index withn META-INF
cd $CORE_HOME/patches
echo $PATCH_NAME >> META-INF/patch.index

