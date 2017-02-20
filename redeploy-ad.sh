#!/bin/sh
ad
svn up ../

./ccadmin.sh create-application
./ccadmin.sh deploy-to-all-appservers
