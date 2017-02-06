#!/bin/sh
#. config.sh

cd $WSS
svn up
cd bin
./ccadmin.sh create-application
./ccadmin.sh deploy-to-all-appservers


