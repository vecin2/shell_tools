#!/bin/sh

kill -9 $(ps -ef | grep java |  grep jboss | grep Standalone | awk '{print $2}')

