
# --- PATH ---
fish_add_path ~/.local/bin

if status is-interactive
    oh-my-posh init fish --config (omp-random-theme) | source
end

# random eza directory color each session
set -l eza_dir_hues 39 45 51 75 99 111 118 141 147 156 173 183 208 214 225
set -gx EZA_COLORS "di=1;38;5;"(random choice $eza_dir_hues)

set fish_greeting "Hola!! :)"

# --- defaults ---
set -gx EDITOR nvim
set -gx VISUAL nvim

# --- zoxide (smart cd) ---
if type -q zoxide
    zoxide init fish | source
end

# --- direnv (auto project envs) ---
if type -q direnv
    direnv hook fish | source
end

# --- fzf integration (handled by fzf.fish Fisher plugin) ---

# --- helpful aliases ---
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

if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\cF --git_log=\cL --git_status=\cS --history=\cR --processes=\cP --variables=\cV
end

# --- git aliases ---
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
alias tm=tmux
alias tml='tm ls'
alias tma='tm attach -t'
alias tma0='tma 0'
alias tms='tm switch-client -t'
alias tms0='tms 0'
alias ompt='omp-theme'
alias pclaude="claude"
alias rlclaude="CLAUDE_CONFIG_DIR=~/.claude-rl claude"
mkdir -p ~/.tmux/sockets
set -gx TMUX_TMPDIR ~/.tmux/sockets
