#!/bin/bash
. ./configuration.sh
MONITOR=$1 
MONITOR_NAME=${MONITOR##*/}
BASE=${MONITOR%/*/*}


cd repo

#copy monitor
CUST_MONITORS=SGroup$BASE/Monitors
CUST_MONITOR_NAME=$MODULES_PREFIX$MONITOR_NAME

echo Creating monitor: $CUST_MONITORS 
mkdir -p $CUST_MONITORS
cp $MONITOR.xml $CUST_MONITORS/$CUST_MONITOR_NAME.xml

echo copying $MONITOR to $CUST_MONITORS/$CUST_MONITOR_NAME
cp -r $MONITOR $CUST_MONITORS/$CUST_MONITOR_NAME

#copy reporting data
CUST_DATAS=${CUST_MONITORS%/*}/ReportingData
DATA_NAME=${MONITOR_NAME%FactMonitor}ReportingData
CUST_DATA_NAME=$MODULES_PREFIX$DATA_NAME
REPORT_DATA=$BASE/ReportingData/${DATA_NAME}

echo Creating Reporting data: $CUST_DATAS
mkdir -p $CUST_DATAS
echo copy report data file $REPORT_DATA.xml $CUST_DATAS/$CUST_DATA_NAME.xml
cp $REPORT_DATA.xml $CUST_DATAS/$CUST_DATA_NAME.xml
echo $REPORT_DATA $CUST_DATAS/$CUST_DATA_NAME
cp -r $REPORT_DATA $CUST_DATAS/$CUST_DATA_NAME

#creating database
CUST_DATABASE=SGroupAddCoreWorkflowReportingFacts/Implementation/Database
mkdir -p $CUST_DATABASE
