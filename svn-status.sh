#!/bin/bash
. ./configuration.sh

if [ "$#" -ne 1 ]; then
  ST_PATH=../repository/default/$MODULES_PREFIX*
else
  ST_PATH=$1
fi
svn st $ST_PATH
