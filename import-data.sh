#!/bin/sh

./ccadmin.sh import-data -DimportLocation="/opt/em/projects/prudential/MCCS/AgentDesktop/project/resources/migration/Content.jar"
./ccadmin.sh import-data -DimportLocation="/opt/em/projects/prudential/MCCS/AgentDesktop/project/resources/migration/Rules.jar"
./ccadmin.sh import-data -DimportLocation="/opt/em/projects/prudential/MCCS/AgentDesktop/project/resources/migration/ReleaseMigration.2.16.jar"
./ccadmin.sh import-data -DimportLocation="/opt/em/projects/prudential/MCCS/AgentDesktop/project/resources/migration/ReleaseMigration.jar"

