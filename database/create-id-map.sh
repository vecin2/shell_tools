#!/bin/bash

. ./database.sh

create_id_map(){
	SQL="SELECT '@' || KEYSET || '.' ||KEYNAME FROM CCADMIN_IDMAP where keyset='ED' order by KEYSET, KEYNAME"
	execute_sql "$SQL"
}
