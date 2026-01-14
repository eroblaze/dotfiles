if status is-interactive
    # Commands to run in interactive sessions can go here
end

# pnpm
set -gx PNPM_HOME "/home/eroblaze/.local/share/pnpm"
# dart
set -gx PATH /home/eroblaze/Desktop/Compiler/dart-2021/dart-sdk/bin $PATH

if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Set up fzf key bindings
fzf --fish | source

zoxide init fish | source
