if status is-interactive
    # Commands to run in interactive sessions can go here

    # Theme
    set --global fish_color_autosuggestion brblack
    set --global fish_color_cancel -r
    set --global fish_color_command brgreen
    set --global fish_color_comment brmagenta
    set --global fish_color_cwd green
    set --global fish_color_cwd_root red
    set --global fish_color_end brmagenta
    set --global fish_color_error brred
    set --global fish_color_escape brcyan
    set --global fish_color_history_current --bold
    set --global fish_color_host normal
    set --global fish_color_host_remote yellow
    set --global fish_color_match --background=brblue
    set --global fish_color_normal normal
    set --global fish_color_operator cyan
    set --global fish_color_param brblue
    set --global fish_color_quote yellow
    set --global fish_color_redirection bryellow
    set --global fish_color_search_match white --background=brblack
    set --global fish_color_selection white --bold --background=brblack
    set --global fish_color_status red
    set --global fish_color_user brgreen
    set --global fish_color_valid_path --underline
    set --global fish_pager_color_completion normal
    set --global fish_pager_color_description yellow
    set --global fish_pager_color_prefix white --bold --underline
    set --global fish_pager_color_progress brwhite --background=cyan
    set --global fish_pager_color_selected_background -r

    set WHOME (powershell.exe -Command 'echo $env:HOMEDRIVE$env:HOMEPATH' | tr -d "\r\n")
    set WHOME (wslpath -u $WHOME)

    # Shortcuts
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    alias crontab='crontab -i'
    alias ls='eza --icons --git-ignore'
    alias la='eza -a --icons'
    alias lt='eza -T --icons --git-ignore'
    alias lta='eza -a -T --icons'
    alias tp='trash-put'

    trash-empty 28

    # Powerline
    starship init fish | source

    if test -z $TMUX
        set count 0
        for ses in (tmux list-sessions | cut -d: -f1)
            if string match -qr '^[0-9]+$' -- $ses
                if test $ses -eq $count
                    set count (math $count + 1)
                else if test $ses -gt $count
                    tmux rename-session -t $ses $count
                    set count (math $count + 1)
                end
            end
        end

        set ses (tmux list-sessions)
        if test -z $ses[1]
            exec tmux new-session
        else
            set out 'Without tmux'
            set new 'Create new session'
            set ses $ses $new $out
            set ses (printf '%s\n' $ses | fzf | cut -d: -f1)
            if test -n "$ses"
                if test $ses = $out
                    return
                else if test $ses = $new
                    exec tmux new-session -s $count
                else
                    exec tmux attach-session -t $ses
                end
            end
        end
    end
end
