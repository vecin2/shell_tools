#!/bin/sh

if [ "$#" -eq 0 ]; then
	FROM_DATE=`date +%Y-%m-%d`
	UPDATE_DB= true
elif [ "$#" -eq 1 ]; then
	FROM_DATE=$1
	UPDATE_DB=false
elif [ "$#" -eq 2 ]; then
	FROM_DATE=$1
	UPDATE_DB= $2
else
	echo Usage from.date=yyyymmdd
	return 1
fi

CORE_HOME=/opt/em/projects/prudential/MCCS/AgentDesktop/ 
EXPORT_LOCATION=$CORE_HOME/migration/exportedReleaseMigration
FILE_NAME=ReleaseMigration.jar
EXTRACT_FOLDER=ReleaseMigration

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
unzip ./$FILE_NAME  -d $EXTRACT_FOLDER
        
echo  "\n  Overriding current migration files with exported ones"
#rm -r $EXPORT_LOCATION/META-INF
#cp $EXPORT_LOCATION/*.* $EXTRACT_FOLDER 

echo  "\n Packing new jar and overriding existing one"
#cd $EXTRACT_FOLDER
#zip -r ../$FILE_NAME .
        
echo  "\n Cleaning exploded directories"
#cd ..   
#rm -r $EXTRACT_FOLDER 
        
echo  "\n Reimporting jar to check there is erros"
cd $CORE_HOME/bin
#./ccadmin.sh import-data -Dimport.location=$CORE_HOME/project/resources/migration/$FILE_NAME

return $?

