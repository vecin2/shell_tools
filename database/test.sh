#!/bin/ksh

get_asm() {
	$ORACLE_HOME/bin/sqlplus -s /nolog <<EOF
	connect / as sysdba
	col path format a35
	col CREATE_DATE format a20
	set lines 132
	set trims on
	set tab off
	set pages 2000
	select inst_id, DISK_NUMBER, header_status, 
		state,path,TOTAL_MB,FREE_MB,
		to_char(CREATE_DATE,'yyyy-mon-dd hh24:mi') CREATE_DATE 
		from gv\$asm_disk;
		EOF
	}

	ASMDISK=$1
	if [ ${ASMDISK}"x" == "x" ]; then
		get_asm;
	else
		get_asm | egrep "INST_ID|^--|${ASMDISK}"
	fi
