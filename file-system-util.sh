#!/bin/bash 
#this script allows to iterate through all the migration files and remove the ones
# that don't want to be refreshed

prompt_remove_files(){
	for filepath in $1; do
		if [ "$filepath" == "$1" ]; then
			echo "No files to expand within $1"
			return 1
		fi
		filename=`basename $filepath`
		read -p "$filename Do you want to refresh this file(y/n/a)?" choice

		case $choice in
			[Yy]* ) echo Yes; ;;
			[Nn]* ) echo No;rm $filepath ;;
			[Aa]* ) echo All; break;;
		esac
	done
}
