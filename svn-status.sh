#!/bin/sh

if [ "$#" -ne 1 ]; 
then
  REPO_PATH=Pru
else
  REPO_PATH=$1
fi
svn status ../repository/default/$REPO_PATH*

