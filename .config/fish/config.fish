
# exports
export LIBRARY_PATH=/usr/local/Cellar/gsl/1.16/lib/
export PATH="/opt/homebrew/bin/:$PATH"
export PATH="/Library/PostgreSQL/15/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export NODE_OPTIONS=''
export PATH="$PATH:$(yarn global bin)"


if status is-interactive
    # Commands to run in interactive sessions can go here
    oh-my-posh init fish --config ~/.config/oh-my-posh/current.omp.json | source
end

set fish_greeting "Hola!! :)"

# Setting PATH for Python 3.10
# The original version is saved in /Users/rahulpinjarla/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"

# --- defaults ---
set -gx EDITOR nvim
set -gx VISUAL nvim

# --- starship prompt ---
#if type -q starship
#  starship init fish | source
#end

# --- zoxide (smart cd) ---
if type -q zoxide
    zoxide init fish | source
end

# --- direnv (auto project envs) ---
if type -q direnv
    direnv hook fish | source
end

# --- fzf integration ---
# Newer fzf versions:
if type -q fzf
    fzf --fish | source
end

# --- helpful aliases (optional) ---
if type -q nvim
    alias v="nvim"
end
alias g="git"
if type -q lazygit
    alias lg="lazygit"
end
if type -q bat
    alias cat="bat"
end
if type -q eza
    alias ls="eza --group-directories-first --icons"
    alias ll="eza -lah --group-directories-first --icons"
end
if type -q rg
    alias grep="rg"
end

# --- Go tooling path (optional, only if you use Go) ---
# fish_add_path (go env GOPATH)/bin

fzf_configure_bindings --directory=\cF --git_log=\cL --git_status=\cS --history=\cR --processes=\cP --variables=\cV

# OpenClaw Completion
source "/Users/rahulpinjarla/.openclaw/completions/openclaw.fish"


# aliases
alias nvim="/opt/homebrew/bin/nvim"
alias dmts="git checkout staging && git pull origin staging && git pull origin main && git push && git checkout main"
alias dmtp="git checkout production && git pull origin production && git pull origin main && git push origin production && git checkout main"
alias dpftp="git checkout production && git pull origin prod-fixes && git pull origin prod-fixes && git push origin production && git checkout main"
alias dc="docker compose"
alias dcb="docker compose build"
alias dcu="docker compose up"
alias dcud="docker compose up -d"
alias dcd="docker compose down"
alias dcdro="docker compose down --remove-orphans"
alias dcr="docker compose restart"
alias dcl="docker compose logs -f"
alias gp="git push"
alias gpl="git pull"
alias gplom="git pull origin main"
alias gplod="git pull origin develop"
alias gs="git stash"
alias gco="git checkout"
alias gcob="gco -B"
alias gcod="gco develop"
alias gcom='gco main'
alias gsp='gs push'
alias gspop='gs pop'
alias gcm='git commit -m'
alias gr='gcod && gpl'
alias pm='python manage.py'
alias pmmm='pm makemigrations'
alias pmm='pm migrate'
alias cl='clear'
alias pxy='ssh -D 9000 -i ~/Documents/pyjamahr-production-shareable.pem pyjamahr-production@57.159.24.29'
alias tm=tmux
alias tml='tm ls'
alias tma='tm attach -t'
alias tma0='tma 0'
alias tms='tm switch-client -t'
alias tms0='tms 0'
alias ompt='omp-theme'
