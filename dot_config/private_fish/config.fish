set fish_greeting

fish_add_path --global "$HOME/.local/bin"
fish_add_path --global "$HOME/.local/bin/fzf/bin"
fish_add_path --global "$HOME/.config/cargo/bin"

set nvm_default_version latest

set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'
set -gx TERMINAL 'wezterm'

if status is-interactive
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_replace_one underscore
  set fish_cursor_visual block
  set fish_vi_force_cursor 1
  fish_vi_key_bindings
  fish_vi_cursor
  fzf_key_bindings

  # Add command abbreviation
  abbr -a dc docker compose
  abbr -a ls exa -lh
  abbr -a vim nvim
  abbr -a cm chezmoi
  abbr -a gl glab

  abbr -a g git
  abbr -a ga git add
  abbr -a gc git commit

  abbr -a tm tmux
  abbr -a ta tmux attach -t


  set -gx QT_STYLE_OVERRIDE kvantum
  # set QT_QPA_PLATFORMTHEME qt5ct

else

  # Used for GPG asking for password using curses
  set -gx GPG_TTY (tty)

end

