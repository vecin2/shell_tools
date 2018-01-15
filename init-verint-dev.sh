#!/bin/sh

./ccadmin.sh toolbox

./windows-up.sh
./oracle-up.sh

sleep 5
./start-all-applications.sh

./ad-run.sh

