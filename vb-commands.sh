#!/bin/sh


start_vm(){
	MACHINE_NAME=$1
	PARAMS=$2
	IS_UP=$(vboxmanage showvminfo $MACHINE_NAME | grep -c "running (since")
	if [ $IS_UP -eq 0 ]; then
		VBoxManage startvm $MACHINE_NAME $PARAMS
		echo Starting machine $MACHINE_NAME
	fi
}

poweroff(){
	MACHINE_NAME=$1
	VBoxManage controlvm $MACHINE_NAME poweroff
}
