#!/bin/bash

. ./configuration.sh

TEMP_FOLDER=$CORE_HOME/resources/jasper/tempJasperExport


mkdir -p TEMP_FOLDER
unzip $1 -d $TEMP_FOLDER
cp -r $TEMP_FOLDER/. $TEMP_FOLDER/../sqlServer/reports/
rm -r $TEMP_FOLDER
