#!/bin/sh

if [ "$#" -eq 1 ]; 
then
	echo No repository path enter, using project specific modules
elif [ "$#" -ne 2 ];
then
	echo Usage commit.message ="a commit message must be entered", repo.path="the path within repository to look for commit (optional, its default to project specific modules)"
	return 1
fi

./svn-status.sh $2 | grep -v \? | awk '{print $2}' | xargs echo svn commit -m \"$1\"  
./svn-status.sh $2 | grep -v \? | awk '{print $2}' | xargs echo svn commit -m \"$1\"  | bash
