set -gx BROWSER firefox
set -gx EDITOR hx

status is-login; and begin
    # Login shell initialisation
end

status is-interactive; and begin
    # Abbreviations


    # Aliases
    alias ar 'php artisan'
    alias cat 'bat -p'
    alias cp 'cp -v'
    alias grep rg
    alias l 'eza -l --icons --git -a'
    alias la 'eza --all'
    alias ll 'eza --all --long --classify'
    alias ls eza
    alias lt 'eza --tree'
    alias mv 'mv -v'
    alias rm 'rm -v'

    # Interactive shell initialisation
    fzf --fish | source

    set -U fish_greeting

    fish_add_path /home/damian/.cargo/bin
    fish_add_path /home/damian/.config/herd-lite/bin

    fish_config theme choose "Dracula Official"

    zoxide init fish --cmd cd | source

    function yy
        set tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    if test "$TERM" != dumb
        starship init fish | source
    end

    direnv hook fish | source
end
