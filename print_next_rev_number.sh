#!/bin/bash


cd ../bin/; REV_NUMBER=$(svn up | cut -d " " -f 3 | sed 's/\.//g'); echo $(($REV_NUMBER+1))
