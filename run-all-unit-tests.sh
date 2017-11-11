#!/bin/bash

./run-tests.sh http://localhost:8280/GTConnect/TestSuiteAcceptor?gtxInitialProcess=UnitTests.PackageRunners.RunAllTests&submit=Run
#WID=`xdotool search --name "Mozilla Firefox" | head -1`
#xdotool windowactivate $WID
#xdotool key F5
#echo $(xdotool getwindowname $(xdotool search --name "Mozilla Firefox"))
