#!/bin/sh

. ./vb-commands.sh

./toolbox-kill.sh

poweroff "Win7_ENT"
poweroff "oracle12c"

./stop-all-applications.sh




