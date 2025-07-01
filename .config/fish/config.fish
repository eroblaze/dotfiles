if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set up fzf key bindings
fzf --fish | source

# pnpm
set -gx PNPM_HOME "/home/eroblaze/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
