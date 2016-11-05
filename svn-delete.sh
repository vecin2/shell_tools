#!/bin/sh
./svn-status.sh | grep ^\! | awk '{print $2}' | xargs svn delete  
