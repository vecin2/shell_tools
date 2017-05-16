#!/bin/sh

. ./appserver-base.sh

./ad-kill-session.sh
./ccadmin.sh start-appserver

./ad-run.sh
