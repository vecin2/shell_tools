#!/bin/sh

kill -9 $(ps -ef | grep java |  grep AgentDesktop/logs/ | grep Standalone | awk '{print $2}')

