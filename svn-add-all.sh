#!/bin/sh
./svn-status.sh $1 | grep ^\? | awk '{print $2}' | xargs svn add --force
