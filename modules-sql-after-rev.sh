#!/bin/bash

if [ $# -ne 1 ]; then
	echo Usage: revision.number: marks the revision number after which will be shown all the scripts 
	exit 1
			
fi
 grep -r \$Revision ../modules/SPEN* | sort  | while read -r line; do
	 revision=$(echo "${line##*\$Revision:[[:space:]]}" | cut -d " " -f1)
	 file_path=${line%%:*}
	 if [ $revision -gt $1 ]; then
		 echo Revision: $revision
		 echo File path: $file_path
	 fi
 done
