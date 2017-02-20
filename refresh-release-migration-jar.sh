#!/bin/sh

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

CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop/ 
EXPORT_LOCATION=$CORE_HOME/migration/exportedReleaseMigration
FILE_NAME=ReleaseMigration.jar
EXTRACT_FOLDER=ReleaseMigration

echo Refresing migration jar from date: $FROM_DATE
if [ $UPDATE_DB = true ]; then
	echo "\n Making sure database is up to date"
	svn up $CORE_HOME/modules
	$CORE_HOME/bin/ccadmin.sh upgrade-database
fi


echo "\n Exporting data"
./ccadmin.sh export-data -DfromDate=$FROM_DATE -DexportLocation=$EXPORT_LOCATION -Ddomain="Content,Business Configuration" -DclearExportLocation=true

echo "\n Making sure jar file is up to date"
cd $CORE_HOME/project/resources/migration
rm $FILE_NAME
svn up

echo  "\n Extracting current jar to $CORE_HOME/project/resources/migration/$EXTRACT_FOLDER"
rm -rf $EXTRACT_FOLDER
unzip ./$FILE_NAME  -d $EXTRACT_FOLDER

#function provide within file imported
echo Reviewing list of files exported:
prompt_remove_files "$EXPORT_LOCATION/*.json"

echo  "\n  Overriding current migration files with exported ones"
rm -r $EXPORT_LOCATION/META-INF
cp $EXPORT_LOCATION/*.* $EXTRACT_FOLDER 

echo  "\n Packing new jar and overriding existing one"
cd $EXTRACT_FOLDER
zip -r ../$FILE_NAME .
        
JAR_FILE_PATH$CORE_HOME/project/resources/migration/$FILE_NAME
read -p  "\n Do you want to reimport jar to check there is errors(y/n)?" choice
case $choice in
	[Yy]* ) cd $CORE_HOME/bin;./ccadmin.sh import-data -Dimport.location=$JAR_FILE_PATH; ;;
	esac
#cd $CORE_HOME/bin
#./ccadmin.sh import-data -Dimport.location=$CORE_HOME/project/resources/migration/$FILE_NAME

if [ $? -eq 0 ];then
read -p  "\n Do you want to commit ReleaseMigration.jar(y/n)?" choice
case $choice in
	[Yy]* ) read -p "\n Please enter commit message:\n " MESSAGE;cd $JAR_FILE_PATH;svn ci -m "$MESSAGE"; ;;
	esac
fi
return $?
