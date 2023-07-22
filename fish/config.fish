if status is-interactive
  # Commands to run in interactive sessions can go here
  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
  alias tp='trash-put'
  alias crontab='crontab -i'
  alias py='python3.9'
  alias pip='python3.9 -m pip'
  alias sumatra='/mnt/c/Users/RyuRyu/AppData/Local/SumatraPDF/SumatraPDF.exe'
  alias ls='exa --git-ignore --icons'
  alias la='exa -a --icons'
  alias lt='exa -T --git-ignore --icons'
  alias rename='/usr/bin/rename'

  # set -U STUDY '/mnt/c/Users/RyuRyu/OneDrive - Kyoto University/study'
  # set -U FISH_CONFIG '/home/ryuryu/.config/fish/config.fish'

  # set -U fish_greeting
  # set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
  # set -Ux COLORTERM truecolor
  # set -Ux BAT_THEME my_gruvbox

  # set -U fish_color_autosuggestion      brblack
  # set -U fish_color_cancel              -r
  # set -U fish_color_command             brgreen
  # set -U fish_color_comment             brmagenta
  # set -U fish_color_cwd                 green
  # set -U fish_color_cwd_root            red
  # set -U fish_color_end                 brmagenta
  # set -U fish_color_error               brred
  # set -U fish_color_escape              brcyan
  # set -U fish_color_history_current     --bold
  # set -U fish_color_host                normal
  # set -U fish_color_match               --background=brblue
  # set -U fish_color_normal              normal
  # set -U fish_color_operator            cyan
  # set -U fish_color_param               brblue
  # set -U fish_color_quote               yellow
  # set -U fish_color_redirection         bryellow
  # set -U fish_color_search_match        'bryellow' '--background=brblack'
  # set -U fish_color_selection           'white' '--bold' '--background=brblack'
  # set -U fish_color_status              red
  # set -U fish_color_user                brgreen
  # set -U fish_color_valid_path          --underline
  # set -U fish_pager_color_completion    normal
  # set -U fish_pager_color_description   yellow
  # set -U fish_pager_color_prefix        'white' '--bold' '--underline'
  # set -U fish_pager_color_progress      'brwhite' '--background=cyan'

  # fzf_key_bindings

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

trash-empty 28
