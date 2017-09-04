#!/bin/bash

. ./migration/refresh-migration-jar.sh
DATE=$1
export_and_update_jar migration-ADtags.jar "Content" $1
