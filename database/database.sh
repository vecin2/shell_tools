#!/bin/bash


execute_sql(){
	if [ $# -ne 1 ]; then
		echo Usage: sql to execute
		echo number of params was $#
		exit 1
	fi
	SQL=$1
	sqlplus SPEN_blueprint/SPEN_blueprint@oracle:1521/orcl12c <<EOF
spool ./id.map
$SQL;
spool off
exit;
EOF
}

