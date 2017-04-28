#!/bin/sh

wget --spider http://localhost:8280/SPAdmin
IS_UP=$?

if [ $IS_UP -gt 0 ]; then
	./ccadmin.sh start-all-appservers
fi

