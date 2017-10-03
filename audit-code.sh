#!/bin/sh
./ccadmin.sh audit-code -Danalysers="Broken Imports,Missing Procedures,Orphaned Procedures" -Dincludes=SPEN*/**/*

if [ $? -ne 0 ]; then
  vi $AD/logs/reports/audit-code.html
fi
