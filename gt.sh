#!/bin/bash
command=$1
#pass all the parameter down except the first one
shift
./xml/commands/$command.sh $@
