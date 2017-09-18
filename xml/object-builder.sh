
import_package(){
	package_path=$1
	class_name=${package_path##*/}
	xml_import_declaration "$class_name"
	xml_package_specifier "$class_name"


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
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry -t elem -n ImportDeclaration -v "" -i '//ImportDeclaration[last()]' -t attr	-n name -v $1)
}
xml_package_specifier(){
	xml=$(echo $xml | xmlstarlet ed -s "//ImportDeclaration[last()]" -t elem -n PackageSpecifier -v "")
	 
}
xml_package_name(){
	xml=$(echo $xml | xmlstarlet ed -s "//ImportDeclaration[last()]/PackageSpecifier" -t elem -n PackageName -v "" -i "//ImportDeclaration[last()]/PackageSpecifier/PackageName[last()]" -t attr -n name -v $1)
}
xml_package_entry_reference(){
	xml=$(echo $xml | xmlstarlet ed -s "//ImportDeclaration[last()]" -t elem -n PackageEntryReference -v "" -i '///ImportDeclaration[last()]/PackageEntryReference' -t attr -n name -v $1)
}

xml_object_definition(){
	xml=$(echo $xml |  xmlstarlet ed -s PackageEntry -t elem -n ObjectDefinition -v "" -i "//ObjectDefinition" -t attr -n designNotes -v "Undefined" -i "//ObjectDefinition" -t attr -n name -v "TestClassUnderTest" -i "//ObjectDefinition" -t attr -n version -v "4.3.0")
}
add_field(){
	field_type=$1
	field_name=$2
	xml_instance_fields
	xml_object_field $1 $2
}
xml_instance_fields(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ObjectDefinition -t elem -n InstanceFields -v "")
}

xml_object_field(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ObjectDefinition/InstanceFields -t elem -n ObjectField -v "" -i "//ObjectField" -t attr -n isAggregate -v "false" -i "//ObjectField" -t attr -n name -v "$1")
	xml_obj_loc
	xml_type_def_ref
}
xml_obj_loc(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ObjectDefinition/InstanceFields/ObjectField -t elem -n ObjectField_loc -v "" -i "//ObjectField_loc" -t attr -n locale -v "")
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ObjectDefinition/InstanceFields/ObjectField/ObjectField_loc -t elem -n Format -v "")
}
xml_type_def_ref(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ObjectDefinition/InstanceFields/ObjectField -t elem -n TypeDefinitionReference -v "" -i "//TypeDefinitionReference" -t attr -n "name" -v "ClassUnderTest")
}

inherit_from(){
	obj_def_path="/PackageEntry/ObjectDefinition"
	super_class_path=$obj_def_path/Superclass
	xml=$(echo $xml | xmlstarlet ed -s $obj_def_path -t elem -n Superclass -v "" -i $super_class_path -t attr -n name -v $1 -i $super_class_path -t attr -n nested -v false)
}

