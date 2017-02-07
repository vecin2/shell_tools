#!/bin/sh
cd ../bin
#svn status repository/default/Pru* | awk '{print $2}' | xargs echo svn commit -m "$1"  
#svn status repository/default/Pru* | awk '{print $2}' | xargs echo svn commit -m "$1"  | bash

./svn-status.sh $2 | awk '{print $2}' | xargs echo svn commit -m "$1"  
./svn-status.sh $2 | awk '{print $2}' | xargs echo svn commit -m "$1"  | bash
