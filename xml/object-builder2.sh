
import_package(){
	package_path=$1
	class_name=${package_path##*/}
	xml_import_declaration "$class_name"
	xml_package_specifier


	array=(${package_path//\// })
	

	last_index=$((${#array[@]} - 1)) 	
	for index in "${!array[@]}"
	do
		#echo element $index: ${array[$index]}
		if [ $index -lt $last_index ]; then
			xml_package_name ${array[$index]}
		else
			xml_package_entry_reference ${array[$index]}	
		fi
	done
}

xml_import_declaration(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry -t elem -n ImportDeclaration -v "" -i '//ImportDeclaration[last()]' -t attr	-n name -v KTestCase)
}
xml_package_specifier(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ImportDeclaration -t elem -n PackageSpecifier -v "")
	 
}
xml_package_name(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ImportDeclaration/PackageSpecifier -t elem -n PackageName -v "" -i '//PackageName[last()]' -t attr -n name -v $1)
}
xml_package_entry_reference(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ImportDeclaration -t elem -n PackageEntryReference -v "" -i '/PackageEntry/ImportDeclaration/PackageEntryReference[last()]' -t attr -n name -v $1)
}

xml_object_definition(){
	xml=$(echo $xml |  xmlstarlet ed -s PackageEntry -t elem -n ObjectDefinition -v "" -i "//ObjectDefinition" -t attr -n designNotes -v "Undefined" -i "//ObjectDefinition" -t attr -n name -v "TestClassUnderTest" -i "//ObjectDefinition" -t attr -n version -v "4.3.0")
}
