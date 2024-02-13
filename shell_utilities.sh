# utility aliases
alias md=mkdir

# utility functions
mcd () {
	mkdir "$@" && cd "${@: -1}"
} 


# build commands
alias m="make -j16"

# lazygit
alias lg="lazygit"

# lazygit
alias lad="lazydocker"

# start docker
alias start_docker="systemctl start docker"

# neovim alias 
alias nv="nvim"

# vim alias
alias v="vim"

# proxy
alias proxy="export {http,https,ftp}_proxy=\"http://nmurr@localhost:3128\""

# go to git home
alias pr="cd \`git rev-parse --show-toplevel\`"

# go to home/dev directory
alias dev="cd $PROJECT_ROOT"

# open ranger file explorer
alias f=ranger

# open project in project_root
op () {
    local project_root="$PROJECT_ROOT"

    local i
    for i in "$@"; do
        case "$i" in 
            -p | --project-root)
                shift
                project_root="$1"
                shift 
                ;;
            -p=* | --project-root=*)
                project_root="${i#*=}"
                project_root="${project_root/\~/$HOME}"
                shift
                ;;
            -* | --*)
                echo "Unknown option $i";
                return 1;
        esac
    done

    if [[ -z "$@" ]]; then
        local v=`ls "$project_root" | fzf`
    else
        local v=`ls "$project_root" | fzf -1 -q "$@"`
    fi
    
    if [[ -z "$v" ]]; then
        return -1;
    fi

    cd "$project_root/$v";
}

# open nvip with a project
nvp() {
    op "$@" && nvim
}

# open nvip with a project
opb() {
    op "$@" && cd build
}

# setting conan user. 
alias conan_init="source \"$HOME/.conan_login.sh\""

function jo() {
	ID="$$"
	mkdir -p /tmp/$USER
	OUTPUT_FILE="/tmp/$USER/joshuto-cwd-$ID"
	env joshuto --output-file "$OUTPUT_FILE" --change-directory $@
	exit_code=$?

	case "$exit_code" in
		# regular exit
		0)
			;;
		# output contains current directory
		101)
			JOSHUTO_CWD=$(cat "$OUTPUT_FILE")
			cd "$JOSHUTO_CWD"
			;;
		# output selected files
		102)
			;;
		*)
			echo "Exit code: $exit_code"
			;;
	esac
}
