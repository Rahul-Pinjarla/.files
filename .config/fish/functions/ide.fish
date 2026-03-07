function ide
    set name (basename (pwd) | string replace -a '.' '_')

    # Create/attach session in current dir, open nvim in pane 0
    tmux new-session -A -s $name -c (pwd) \; \
        send-keys nvim C-m \; \
        split-window -h -p 30 -c (pwd) \; \
        split-window -v -p 50 -c (pwd) \; \
        select-pane -t 0

    # Top-right: Claude Code if available
    if type -q claude
        tmux send-keys -t "$name":0.1 claude C-m
    else if type -q claude-code
        tmux send-keys -t "$name":0.1 claude-code C-m
    end

    # Bottom-right: test watcher (Go example; change to your stack)
    if type -q watchexec
        tmux send-keys -t "$name":0.2 "watchexec -r 'echo; echo Running tests...; go test ./...'" C-m
    end
end
