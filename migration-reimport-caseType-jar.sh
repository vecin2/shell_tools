#!/bin/bash

SHELL_DIR=$(pwd)
cd ../migration/
svn up

echo "Changing directory back to $SHELL_DIR"
cd $SHELL_DIR 

./ccadmin.sh import-data -DimportLocation=/opt/verint/verint_projects/SPEN/FP3/project/migration-jar/migration-3PDCaseType.jar

