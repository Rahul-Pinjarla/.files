if status is-interactive
    # Commands to run in interactive sessions can go here
    oh-my-posh init fish --config ~/.config/oh-my-posh/current.omp.json | source
end

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

fzf_configure_bindings --directory=\cF --git_status=\cG --history=\cR
export PATH=$PATH:/Applications/Ghostty.app/Contents/MacOS
