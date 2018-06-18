# Completions for govc

set -l progname govc
complete -e -c $progname
complete -c $progname -f

function __fish_vm  --description 'Test if command should have vm as potential completion'
	for i in (commandline -opc)
		if string match -qr "vm.*" -- $i
			return 0
		end
	end
	return 1
end

set -l listvm "($progname ls -l '/**/vm/*'|string replace ' ' \t)"
set -l noopt "not $hasopt"


for c in (govc -h |command grep -v Usage| tr -s '\n' ' ')
    complete -c $progname -a $c
end

complete -c $progname -n '__fish_vm' -xa "$listvm"
