function f --wraps="fzf --preview 'bat --style=numbers --color=always {}'" --description "alias f=fzf --preview 'bat --style=numbers --color=always {}'"
  fzf --preview 'bat --style=numbers --color=always {}' $argv
        
end
