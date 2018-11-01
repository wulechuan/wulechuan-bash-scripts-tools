function setup-bash-prompt {
	function generate-prompt-string {
		PS1=$clearColor'\n'                                                                    # New line

		PS1=$PS1$(date +"%m-%d %H:%M:%S ")
		PS1=$PS1$(getCurrentUserName)'@\h:\w'
		PS1=$PS1'\n'
		PS1=$PS1'# '
	}

	export PROMPT_COMMAND='generate-prompt-string';
}
