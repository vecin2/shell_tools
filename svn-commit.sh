#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo Usage {repository.path}
  return 1
fi

svn commit ../../repository/default/$1 -m "$2"

