#!/bin/bash

. ./configuration.sh

./svn-status.sh "../modules/$MODULES_PREFIX*"
