#!/bin/bash

. ./migration/refresh-migration-jar.sh
DATE=$1
export_and_update_jar migration-3PDCaseType.jar "Business Configuration" $1
