#!/bin/bash
. ./configuration.sh

REPO_PATH=../repository/default/
if [ "$#" -ne 1 ]; then
  ST_PATH=$REPO_PATH/$MODULES_PREFIX* 
else
  ST_PATH=$1
fi

if [ -d $REPO_PATH/TestTools ]; then
	ST_PATH="$ST_PATH $REPO_PATH/TestTools"
fi
if [ -d $REPO_PATH/UnitTests ]; then
	ST_PATH="$ST_PATH $REPO_PATH/UnitTests"
fi

ST_PATH="$ST_PATH ../config/project.properties ../patches"
svn st $ST_PATH
