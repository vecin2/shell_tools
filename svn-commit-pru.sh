#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo Usage {module.name}
  echo Usage {commit.message}
  return 1
fi

svn cl my-change-list $(./svn-status.sh $1 | awk '{print $2}')
svn commit -m $2 --changelist my-change-list
