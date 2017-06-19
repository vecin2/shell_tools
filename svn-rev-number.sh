#!/bin/bash

svn_rev_number(){
	PWD=$(pwd)
	cd ../bin/
	REV_NUMBER=$(svn up | cut -d " " -f 3 | sed 's/\.//g')
	NEXT_REV_NUMBER=$(($REV_NUMBER+1))
	cd $PWD
	echo $NEXT_REV_NUMBER
}

modules_rev_number(){
	MODULES_REV_NUMBER=$(find ../modules/SGroup* -name update.sequence | xargs cat | cut -d " " -f 3 | sort -V | tail -n1)
	echo $MODULES_REV_NUMBER
}

