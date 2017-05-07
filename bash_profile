function parse_git_dirty {
   [[ $(git status | grep clean 2> /dev/null | tail -n1) == "" ]] && echo "*"
}
function checker {
        echo "\[\033[1;31m\]*"
}
function parse_git_branch {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
    fi
}

function pre_prompt {
	newPWD="${PWD}"
	user="whoami"
	host=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
	let promptsize=$(echo -n "┌─(\u@\w)(< 12:12PM >)┐"| wc -c | tr -d " ")
	let fillsize=${COLUMNS}-${promptsize}
	fill=""
	while [ "$fillsize" -gt "0" ] 
	do 
  		fill="${fill}─"
 		let fillsize=${fillsize}-1
	done
	if [ "$fillsize" -lt "0" ]
	then
  	let cutt=3-${fillsize}
	fi
}

PROMPT_COMMAND=pre_prompt

export PS1='\[\033[0;38;5;111m\]┌─[\[\033[0m\]\[\[\033[0m\]\u\[\033[0m\]\[\033[0;38;5;111m\]]${fill}< \[\033[0;38;5;3m\]$(date "+%I:%M%p")\[\033[0;38;5;111m\] >─┐
└──\[\033[1;35m\]@\[\033[1;32m\]\w\[\033[0;38;5;45m\]$(parse_git_branch)\[\033[0m\]$ '

export PATH=$PATH:/usr/local/share/npm/bin
export GREP_OPTIONS='--color=auto'
