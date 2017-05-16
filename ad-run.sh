#!/bin/bash

. ./appserver-base.sh 

BROWSER="firefox -new-tab"
URL="http://localhost:8280/GTConnect/UnifiedAcceptor/FrameworkDesktop.Main"
run_app $BROWSER  $URL
