if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Add command abbreviation

abbr -a dc docker compose
abbr -a ls exa -lh
abbr -a vim nvim
abbr -a cm chezmoi

abbr -a g git
abbr -a ga git add
abbr -a gc git commit

abbr -a tm tmux
abbr -a ta tmux attach -t

fish_add_path --append "$HOME/.local/bin"
fish_add_path --append "$HOME/.config/cargo/bin"

# Used for GPG asking for password using curses
set -gx GPG_TTY (tty)
