function omp-theme
    set -l base ~/.config/oh-my-posh
    set -l dir $base/themes
    set -l cur $base/current.omp.json

    switch $argv[1]
        case list
            for f in $dir/*.omp.json
                echo (basename $f .omp.json)
            end

        case install
            for name in $argv[2..-1]
                oh-my-posh config export --config $name --output $dir/$name.omp.json
            end

        case set
            set -l name $argv[2]
            set -l target $dir/$name.omp.json
            if not test -f $target
                echo "Theme not installed: $name"
                echo "Install it with: omp-theme install $name"
                return 1
            end
            ln -sf $target $cur
            oh-my-posh init fish --config $cur | source

        case '*'
            echo "Usage:"
            echo "  omp-theme list"
            echo "  omp-theme install <name> [name...]"
            echo "  omp-theme set <name>"
    end
end
