#!/usr/bin/bash

__git-profile_completion() {
	local current previous options
	COMPREPLY=()
	current="${COMP_WORDS[COMP_CWORD]}"
	previous="${COMP_WORDS[COMP_CWORD-1]}"
	options="--directory --verbose"
	commands=( "set" "save" "list" "completion" "help" "version" )
	require_input=( "set" "save" )

	if [[ ${current} == -* ]]; then
		COMPREPLY=( $(compgen -W "${options}" -- ${current}) )
		return 0
	elif [[ "${require_input[*]}" =~ ${previous} ]]; then
		profiles=""
		if [[ ! -d "~/.gitprofile" ]]; then
			profiles=$(ls ~/.gitprofile)
		fi
		COMPREPLY=($(compgen -W "${profiles}" "${current}"))
		return 0
	else
		COMPREPLY=($(compgen -W "${commands[*]}" "${current}"))
  		return 0
	fi
}

complete -o default -F __git-profile_completion git-profile
