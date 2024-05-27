#!/usr/bin/bash

__git-profile_completion() {
	local current previous options
	COMPREPLY=()
	current="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	options="--directory --verbose"

	if [[ ${current} == -* ]]; then
		COMPREPLY=( $(compgen -W "${options}" -- ${current}) )
		return 0
	fi
}

complete -o default -F __git-profile_completion git-profile
