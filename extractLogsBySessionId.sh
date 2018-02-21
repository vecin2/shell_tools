#!/bin/bash
set -o errexit -o nounset -o pipefail


extract_logs(){
	if [ "$#" -eq 1 ]; then
#if no path passed look for zip files in current folder
		zip_path="./"
	elif [ "$#" -eq 2 ]; then
		zip_path="$2"
	else
 		echo "Pass session id. Optional zips file or nothing if you want to check zips in the current directory"
		return 1
	fi

	local log_id zip_file logs
	log_id=$1
	current_folder=$(pwd)
	cd $zip_path

	zip_file=$(for f in `ls *.zip`; do echo "$f --> "; unzip -l $f | grep $log_id; done | grep -B1 "/" | grep "\-\->" | sed -e 's/-->//' || true)
	if [ -z "$zip_file" ]; then
		echo "No logs found in directory '$zip_path' with that session id"
		return 1
	fi

	echo Extracting zip file: $zip_file
	logs=$(unzip -l $zip_file | grep -e $log_id -e server | rev | cut -d ' ' -f1 | rev)

	local dest_folder=$current_folder/$log_id
	mkdir -p $dest_folder
	for log in $logs; do unzip -oj $zip_file $log -d $dest_folder; done
}

extract_logs $@
