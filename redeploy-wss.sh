#!/bin/bash

cd $WSS
pwd
svn up
cd bin

./ccadmin.sh create-application
./ccadmin.sh deploy-to-all-appservers
