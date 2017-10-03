
add_square_brackets(){
	result=$(echo "$1" |  sed 's/DOCTYPE ObjectDefinition/DOCTYPE ObjectDefinition []/')
	echo "$result"
}	

print_xml_to_file(){
	dir_name=$(dirname "$2")
	if [ ! -d $dir_name ]; then 
		echo Creating folder $dir_name
		mkdir -p $dir_name
	fi
	echo "$1" > $2
	formatted=$(xmlstarlet fo -R $2)
	formatted=$(add_square_brackets "$formatted")
	echo "$formatted" > $2
}
