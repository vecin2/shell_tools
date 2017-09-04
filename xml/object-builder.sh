#!/bin/bash

set_name(){
	xml=$(echo $xml | xmlstarlet ed -u 'PackageEntry/ObjectDefinition/@name' -v "$1")
}
import_package(){
	xml_import_declaration
	xml_package_specifier
	xml_package_name "TestTools"
	xml_package_name "TestUnit"
	xml_package_name "Objects"
	xml_package_entry_reference "KTestCase"

}
xml_import_declaration(){
	xml=$(echo $xml | xmlstarlet ed -i '/PackageEntry/ObjectDefinition' -t elem -n ImportDeclaration -v "" -i /PackageEntry/ImportDeclaration -t attr -n name -v KTestCase) 
}
xml_package_specifier(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ImportDeclaration -t elem -n PackageSpecifier -v "")
}
xml_package_name(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ImportDeclaration/PackageSpecifier -t elem -n PackageName -v "" -i '/PackageEntry/ImportDeclaration/PackageSpecifier/PackageName[last()]' -t attr -n name -v $1)
}
xml_package_entry_reference(){
	xml=$(echo $xml | xmlstarlet ed -s /PackageEntry/ImportDeclaration -t elem -n PackageEntryReference -v "" -i '/PackageEntry/ImportDeclaration/PackageEntryReference[last()]' -t attr -n name -v $1)
}
add_square_brackets(){
	xml=$(echo $xml |  sed 's/DOCTYPE ObjectDefinition/DOCTYPE ObjectDefinition []/')
}	
inherit_from(){
	obj_def_path="/PackageEntry/ObjectDefinition"
	super_class_path=$obj_def_path/Superclass
	xml=$(echo $xml | xmlstarlet ed -s $obj_def_path -t elem -n Superclass -v "" -i $super_class_path -t attr -n name -v $1 -i $super_class_path -t attr -n nested -v false)

}
