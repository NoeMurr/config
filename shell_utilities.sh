# utility aliases
alias md=mkdir

# utility functions
mcd () {
	mkdir "$@" && cd "${@: -1}"
} 

# lazygit
alias lg="lazygit"

# neovim alias 
alias nv="nvim"

# vim alias
alias v="vim"

# go to git home
alias pr="cd \`git rev-parse --show-toplevel\`"

# go to home/dev directory
alias proj="cd $PROJECT_ROOT"

alias settings="nvim ~/.config/hypr/hyprland.conf"

# open project in project_root
op () {
    local project_root="$PROJECT_ROOT"

    local i
    for i in "$@"; do
        case "$i" in 
            -p | --project-root) shift
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

