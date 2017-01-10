#!/bin/sh

echo Importing Content.jar...
./ccadmin.sh import-data -DimportLocation="/opt/em/projects/prudential/MCCS/AgentDesktop/project/resources/migration/Content.jar"
echo Importing Rules.jar...
./ccadmin.sh import-data -DimportLocation="/opt/em/projects/prudential/MCCS/AgentDesktop/project/resources/migration/Rules.jar"
echo Importing ReleaseMigration.2.16.jar
./ccadmin.sh import-data -DimportLocation="/opt/em/projects/prudential/MCCS/AgentDesktop/project/resources/migration/ReleaseMigration.2.16.jar"
echo Importing ReleaseMigration.jar
./ccadmin.sh import-data -DimportLocation="/opt/em/projects/prudential/MCCS/AgentDesktop/project/resources/migration/ReleaseMigration.jar"

