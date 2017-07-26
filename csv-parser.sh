#!/bin/bash
parse_csv(){
	while IFS=, read FULLNAMES USERNAME
	do
		echo "I got:$FULLNAMES|$USERNAME"
		export FULLNAME=$FULLNAMES
	done < user.csv
}

parse_csv
echo "after function $FULLNAME"


PS3="Please choose a valid option : "
echo columns are $COLUMNS
export COLUMNS=2
OPTIONS=("Create a VM from scratch" "Management Menu" "Command-line Usage" "Quit")
select opt in "${OPTIONS[@]}"; do
	case $opt in
		"Create a VM from scratch")
			createit
			exit
			;;
		"Management Menu")
			mgmtmenu
			exit
			;;
		"Command-line Usage ")
			help
			;;
		"Quit")
			exit
			;;
		*) echo invalid option;;
	esac
done
