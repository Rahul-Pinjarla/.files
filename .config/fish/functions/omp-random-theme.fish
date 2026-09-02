function omp-random-theme --description 'Render current.omp.json with a random catppuccin accent for this session'
    set -l src ~/.config/oh-my-posh/current.omp.json
    set -l cache_dir ~/.cache/oh-my-posh
    set -l out $cache_dir/session-$fish_pid.omp.json

    mkdir -p $cache_dir

    # catppuccin macchiato accent hues
    set -l accents F4DBD6 F0C6C6 F5BDE6 C6A0F6 ED8796 EE99A0 F5A97F EED49F A6DA95 8BD5CA 91D7E3 7DC4E4 8AADF4 B7BDF8
    set -l accent "#"(random choice $accents)

    string replace -- "__ACCENT__" $accent < $src > $out
    echo $out
end
