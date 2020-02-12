if [ -z $AD ]; then
	echo Global variable AD has not been set. Please set it before install it.
	exit
else
	sudo ln -sfv $AD/shell_tools/autocompletion/ccadmin.sh /etc/bash_completion.d/ccadmin
	sudo ln -sfv $AD/shell_tools/autocompletion/gt.sh /etc/bash_completion.d/gt
fi 
completion_file_location="${EM_CORE_HOME}/.em/autocompletion/ccadmin_completion"
if [ ! -f "$completion_file_location" ]; then
	echo "Generating ccadmin options"...
	options=$("${EM_CORE_HOME}"/bin/ccadmin.sh | grep echo | awk '{print $3}')
	echo $options
	mkdir -p "${EM_CORE_HOME}/.em/autocompletion"
	echo "$options"	>"$completion_file_location"
fi
