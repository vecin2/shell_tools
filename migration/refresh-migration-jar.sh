#!/bin/bash

. ./configuration.sh
export_data(){
	printf "\nExporting data from domain $DOMAIN from date:$FROM_DATE"
	rm -r $EXPORT_LOCATION
	$CCADMIN_HOME/ccadmin.sh export-data -DfromDate=$FROM_DATE -DexportLocation=$EXPORT_LOCATION -Ddomain="$DOMAIN" -DclearExportLocation=true
}
refresh_jar_from_svn(){
	echo "Refreshing $JAR_FILE_PATH"
	rm $JAR_FILE_PATH
	svn up $JAR_FILE_PATH
}
prompt_remove_files(){
	echo "Prompting files within $1"
	for filepath in $1; do
		if [ "$filepath" == "$1" ]; then
			echo "No files to expand within $1"
			return 1
		fi
		echo "Getting file name from $filepath"
		filename=`basename "$filepath"`
		read -p "$filename Do you want to refresh this file(y/n/a)?" choice

		case $choice in
			[Yy]* ) echo Yes; ;;
			[Nn]* ) echo No;rm "$filepath" ;;
			[Aa]* ) echo All; break;;
		esac
	done
}
prompt_import_data(){
	read -p  "Do you want to import jar to check if there is any errors(y/n)?" choice
	case $choice in
		[Yy]* ) echo Importing $JAR_FILE_PATH;cd $CORE_HOME/bin;./ccadmin.sh import-data -DimportLocation=$JAR_FILE_PATH; ;;
	esac
}
prompt_commit(){
	if [ $? -eq 0 ]; then
		read -p  "Do you want to commit $JAR_FILE_PATH(y/n)?" choice
		case $choice in
			[Yy]* ) read -p "Please enter commit message: " MESSAGE;cd $CORE_HOME;svn ci $JAR_FILE_PATH -m "$MESSAGE"; ;;
		esac
	fi
	return $?
}
check_params(){
	echo "Number of arguments is: $#, $1,$2,$3"
	if [ "$#" -eq 0 ] || [ "$#" -eq 1 ] || [ "$#" -gt 3 ]; then
		echo "Usage:" 
		echo "  file.name=tags.jar"
		echo "  domain.name=\"S Group Tags,Content,Business Configuration,Knowledge Configuration\""
		echo "  from.date=yyyy-mm-dd (optional)"
		return 1
	fi
	return 0
}

export_and_update_jar(){
	if ! check_params "$1" "$2" "$3"; then
		exit 1
	fi
	if [ "$#" -eq 3 ]; then
		FROM_DATE=$3
	else
		FROM_DATE=`date +%Y-%m-%d`
	fi
	FILE_NAME=$1
	DOMAIN=$2

	CCADMIN_HOME=$CORE_HOME/bin
	MIGRATION_PATH=$CORE_HOME/project/migration-jar
	EXPORT_LOCATION=$MIGRATION_PATH/exportedMigration
	JAR_FILE_PATH=$MIGRATION_PATH/$FILE_NAME

	printf "\nRefreshing $FILE_NAME\n"

	export_data
	refresh_jar_from_svn

	echo Reviewing list of files exported:
	if ! prompt_remove_files "$EXPORT_LOCATION/*.json"; then
		echo "No files have been exported. Please make sure there are changes made for that date and domain."
		exit 1
	fi

	echo -e "\n  Overriding current migration files with exported ones (ignoring $EXPORT_LOCATION/META_INF)"
	cd $EXPORT_LOCATION
	zip -ur $JAR_FILE_PATH .

	prompt_import_data
	prompt_commit
}

