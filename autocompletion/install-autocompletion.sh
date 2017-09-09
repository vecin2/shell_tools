if [ -z $AD ]; then
	echo Global variable AD has not been set. Please set it before install it.
	exit
else
	sudo ln -sfv $AD/shell_tools/autocompletion/ccadmin.sh /etc/bash_completion.d/ccadmin
fi 
