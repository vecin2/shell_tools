#!/bin/bash

./modules-st.sh  | awk '{print $2}' | xargs svn ci -m "$1"
