# Completions for govc

set -l progname govc
complete -e -c $progname
complete -c $progname -f

function __fish_govc_no_subcommand  --description 'Test if govc has yet to be given the subcommand'
	for i in (commandline -opc)
		set -l cmd (govc -h |command grep -v Usage| tr -s '\n' ' ')
        switch $cmd
            case "*$i*"
                return 1
        end
	end
	return 0
end

function __fish_vm  --description 'Test if command should have vm as potential completion'
	for i in (commandline -opc)
		if string match -qr "vm.*" -- $i
			return 0
		end
        if contains -- $i "--vm"
            return 0
        end
	end
	return 1
end

function __fish_ls --description 'Test if command should have ls as potential completion'
	for i in (commandline -opc)
        if contains -- $i "ls"
            return 0
        end
	end
	return 1
end

set -l listvm "($progname ls -l '/**/vm/*'|string replace ' ' \t)"
set -l ls "($progname ls -l '/**/*' | sort -u | string replace ' ' '\t')"

#for c in (govc -h |command grep -v Usage| tr -s '\n' ' ')
complete -c $progname -n '__fish_govc_no_subcommand' -a (govc -h |command grep -v Usage| tr -s '\n' ' ')
#end

complete -c $progname -n '__fish_vm' -xa "$listvm"
complete -c $progname -n '__fish_ls' -xa "$ls"
