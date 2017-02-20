#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo Usage commit.message="a commit message must be entered"
	return 1
fi
cd ../bin
#svn status repository/default/Pru* | awk '{print $2}' | xargs echo svn commit -m "$1"  
#svn status repository/default/Pru* | awk '{print $2}' | xargs echo svn commit -m "$1"  | bash

./svn-status.sh $2 | awk '{print $2}' | xargs echo svn commit -m \"$1\"  
./svn-status.sh $2 | awk '{print $2}' | xargs echo svn commit -m \"$1\"  | bash
