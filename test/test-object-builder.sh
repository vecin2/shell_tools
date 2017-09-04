. ./xml/object-builder.sh

T_import_package(){
    expected="<?xml version=\"1.0\"?><PackageEntry> <ImportDeclaration
        name=\"KTestCase\">
      <PackageSpecifier>
        <PackageName
            name=\"TestTools\" />
        <PackageName
            name=\"TestUnit\" />
        <PackageName
            name=\"Objects\" />
      </PackageSpecifier>
      <PackageEntryReference
          name=\"KTestCase\" />
    </ImportDeclaration> <ObjectDefinition /></PackageEntry>"
		xml="<PackageEntry>
					 <ObjectDefinition />
				 </PackageEntry>"
		import_package /TestTools/TestUnit/Objects/KTestCase
		result=$xml
		assert_equal_xml "$expected" "$result"
}
T_inherit_from(){
	expected="
    <?xml version=\"1.0\"?>
	    <PackageEntry>
	      <ObjectDefinition
        	designNotes=\"Undefined\"
        	name=\"Object\"
        	version=\"4.3.0\" >
				 <Superclass
         		name=\"KTestCase\"
          	nested=\"false\" />
   			 </ObjectDefinition>
			</PackageEntry>"
	xml="<PackageEntry>
	      <ObjectDefinition
        designNotes=\"Undefined\"
        name=\"Object\"
        version=\"4.3.0\" />
				</PackageEntry>"
	inherit_from "KTestCase"			
	assert_equal_xml "$expected" "$xml"
}
#change name to be testclassunder test
#set test name
