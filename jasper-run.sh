#!/bin/bash

. ./appserver-base.sh 
BROWSER=chromium-browser
URL=http://localhost:8280/jasperserver-pro
run_app $BROWSER $URL
