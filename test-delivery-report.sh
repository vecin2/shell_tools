#!/bin/bash
REPORT_PATH="/opt/kana_installs/cpp/cpp_13R1_spen/fileStorage/reporting"
rm $REPORT_PATH/*.*

./ccadmin.sh SPEN-extract-delivery-cases-P2ext

FILE_NAME=$(ls -ltr $REPORT_PATH | rev | cut -f 1 -d " " | rev | tail -n1)

echo $REPORT_PATH/$FILE_NAME
libreoffice $REPORT_PATH/$FILE_NAME
