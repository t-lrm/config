# --- Prompt Customization ---

PS1='\[\e[32m\]\u@\h\[\e[m\]:\[\e[34m\]\w\[\e[m\]\$ '

# --- Aliases ---

# Basic shortcuts
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpt='git push --follow-tags'
alias gt='git tag -ma'
alias gd='git diff'

# Python virtualenv helper
alias venv='source .venv/bin/activate'

# --- Functions ---

# Quick mkcd - make directory and cd into it
mkcd () {
    mkdir -p "$1" && cd "$1"
}

# Extract archives
extract () {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create Rider solution
ridersolution() {
        # Check if an argument is provided
    if [ -z "$1" ]; then
        echo "Error: Please provide a project name as an argument."
        echo "Usage: ridersolution <ProjectName>"
        return 1
    fi
        dotnet.exe new sln --name $1
        dotnet.exe new console -n $1 -f net7.0 -lang 'C#'
        dotnet.exe sln add $1/$1.csproj
        echo -e "# $1\n" > README
        echo -e "bin/\nobj/\n\n.idea/\n*~\n*.DotSettings.user\n" > .gitignore
        dotnet.exe new xunit -n Tests -f net7.0
        dotnet.exe sln add Tests
        dotnet.exe add Tests/Tests.csproj reference $1/$1.csproj
        echo -e "\nglobal using $1;\n" >> Tests/GlobalUsings.cs
        rm Tests/UnitTest1.cs
        tree . -I 'obj|bin|.idea|.git' -a
}

# --- Custom PS1 with git branch info ---
parse_git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's/* //'
}
PS1='\[\e[32m\]\u@\h\[\e[m\]:\[\e[34m\]\w\[\e[m\]$([[ $(parse_git_branch) ]] && echo " (\[\e[31m\]$(parse_git_branch)\[\e[m\])")\$ '
