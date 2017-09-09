_ccadmin() 
{
	local cur 
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[$COMP_CWORD-1]}"


	if [ -z "$CCADMIN_COMPLETION_OPTS" ]; then
		CCADMIN_COMPLETION_OPTS=$($AD/shell_tools/ccadmin.sh  | grep "\[echo\]" | grep -v ":" | awk '{print $2}' | tr  '\n' ' ')
		export CCADMIN_COMPLETION_OPTS
	fi

	if [[ ${prev} == ccadmin ]]; then
		COMPREPLY=( $(compgen -W "${CCADMIN_COMPLETION_OPTS}" -- ${cur}) )
		return 0
	fi
}
complete -o default -F _ccadmin ccadmin
