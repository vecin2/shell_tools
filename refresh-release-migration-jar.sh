#!/bin/bash
. ./configuration.sh

. ./file-system-util.sh
if [ "$#" -eq 0 ]; then
	UPDATE_DB=false
	FROM_DATE=`date +%Y-%m-%d`
elif [ "$#" -eq 1 ]; then
	UPDATE_DB=$1
	FROM_DATE=`date +%Y-%m-%d`
elif [ "$#" -eq 2 ]; then
	UPDATE_DB= $1
	FROM_DATE=$2
else
	echo Usage from.date=yyyy-mm-dd
	return 1
fi

FILE_NAME=tags.jar
#DOMAIN="Content,Business Configuration"
DOMAIN="S Group Tags"
MIGRATION_PATH=$CORE_HOME/migration
EXPORT_LOCATION=$MIGRATION_PATH/exportedMigration
EXTRACT_NAME=migration
JAR_FILE_PATH=$MIGRATION_PATH/$FILE_NAME

FULL_EXTRACT_PATH=$CORE_HOME/migration/$EXTRACT_NAME

echo Refreshing migration jar from date: $FROM_DATE
if [ $UPDATE_DB = true ]; then
	echo "\n Making sure database is up to date"
	svn up $CORE_HOME/modules
	$CORE_HOME/bin/ccadmin.sh upgrade-database
fi

echo "\n Exporting data"
./ccadmin.sh export-data -DfromDate=$FROM_DATE -DexportLocation=$EXPORT_LOCATION -Ddomain="$DOMAIN" -DclearExportLocation=true


if [ -z ${FULL_EXTRACT_PATH} ]; then
	echo Extract folder is unset
	return
else
	echo "Refreshing $JAR_FILE_PATH"
	rm $JAR_FILE_PATH
	svn up $JAR_FILE_PATH

	echo  "\n Extracting $JAR_FILE_PATH to $FULL_EXTRACT_PATH"
	rm -rf $FULL_EXTRACT_PATH
	unzip $JAR_FILE_PATH  -d $FULL_EXTRACT_PATH

	#function within file imported
	echo Reviewing list of files exported:
	if ! prompt_remove_files "/opt/verint/verint_projects/trunk/migration/exportedMigration/*.json"; then
		echo "No files have been exported. Please make sure there are changes made for that date and domain."
		exit 1
	fi

	echo  "\n  Overriding current migration files with exported ones (ignoring $EXPORT_LOCATION/META_INF)"
	rm -r $EXPORT_LOCATION/META-INF
	cp $EXPORT_LOCATION/*.* $FULL_EXTRACT_PATH

	echo  "\n Packing jar  $FULL_EXTRACT_PATH/../$FILE_NAME"
	cd $FULL_EXTRACT_PATH
	zip -r ../$FILE_NAME .
	rm -r $FULL_EXTRACT_PATH
fi	
read -p  "Do you want to import jar to check if there is any errors(y/n)?" choice
case $choice in
	[Yy]* ) echo Importing $JAR_FILE_PATH;cd $CORE_HOME/bin;./ccadmin.sh import-data -DimportLocation=$JAR_FILE_PATH; ;;
esac

if [ $? -eq 0 ]; then
	read -p  "Do you want to commit $JAR_FILE_PATH(y/n)?" choice
	case $choice in
		[Yy]* ) read -p "Please enter commit message: " MESSAGE;cd $CORE_HOME;svn ci $JAR_FILE_PATH -m "$MESSAGE"; ;;
	esac
fi
return $?
