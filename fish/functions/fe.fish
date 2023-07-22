function fe
  set file (fd . $argv[1] --type file --color=always \
    | fzf --ansi --preview 'bat {} --color=always -r:50 --style=grid,header')
  if test -n "$file"
    nvim $file
  end
end

