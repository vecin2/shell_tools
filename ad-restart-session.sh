#!/bin/sh

. ./appserver-base.sh

./ad-kill-session.sh
./ccadmin.sh start-appserver

run_app "firefox -new-tab" "http://localhost:8280/GTConnect/UnifiedAcceptor/FrameworkDesktop.Main"
