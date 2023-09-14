if status is-interactive
  # Commands to run in interactive sessions can go here

  set WHOME (powershell.exe -Command 'echo $env:HOMEDRIVE$env:HOMEPATH' | tr -d "\r\n")
  set WHOME (wslpath -u $WHOME)

  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
  alias tp='trash-put'
  alias crontab='crontab -i'
  alias ls='exa --git-ignore --icons'
  alias la='exa -a --icons'
  alias lt='exa -T --git-ignore --icons'
  alias sumatra=$WHOME/AppData/Local/SumatraPDF/SumatraPDF.exe

  trash-empty 28

  if test -z $TMUX
    set count 0
    for ses in (tmux list-sessions | cut -d: -f1)
      if test $ses -eq $count
        set count (math $count + 1)
      else if test $ses -gt $count
        tmux rename-session -t $ses $count
        set count (math $count + 1)
      end
    end

    set ses (tmux list-sessions)
    if test -z $ses[1]
      exec tmux new-session
    else
      set new 'Create new session'
      set ses $ses $new
      set ses (printf '%s\n' $ses | fzf | cut -d: -f1)
      if test -n "$ses"
        if test $ses = $new
          exec tmux new-session -s $count
        else
          exec tmux attach-session -t $ses
        end
      end
    end
  end
end
