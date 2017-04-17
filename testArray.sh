#!/bin/bash
declare -a names

names[0]="hola pedro"
names[1]=$(echo ${names[0]} | sed 's/ //g')
DEPTH1=1
DEPTH2=2
PARENT_NAME="PARENT_$DEPTH"
declare "PARENT_NAME"="Bank"
declare "PARENT_$DEPTH2"=Mortgage
echo "${!PARENT_NAME}"
echo $PARENT_$DEPTH2

echo ${names[0]}
echo ${names[1]}
DEPTH_VAL=1
CURRENT_PARENT_VAR="PARENT_$DEPTH_VAL"
declare "$CURRENT_PARENT_VAR"="100"

echo $CURRENT_PARENT_VAR: ${!CURRENT_PARENT_VAR}

eval "PARENT_$DEPTH_VAL=5"
eval "echo value is \$PARENT_$DEPTH_VAL"
CURRENT=$(eval "echo \$PARENT_$DEPTH_VAL")
echo printing current is $CURRENT
