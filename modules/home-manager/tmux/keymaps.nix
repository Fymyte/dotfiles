{
  lib,
  config,
  ...
}: let
  advanced-keybinding-support = ''
    # Let other terminal keep their names while enabling supported features
    set -ga terminal-overrides ",foot:Tc,foot:extkeys,foot:256,foot:sync"
    set -ga terminal-overrides ",Kitty:Tc,Kitty:extkeys,Kitty:256,Kitty:sync"
    set -ga terminal-overrides ",ghostty:Tc,ghostty:extkeys,ghostty:256,ghostty:sync"
    set -ga terminal-overrides ",Alacritty:Tc,Alacritty:extkeys,Alacritty:256,Alacritty:sync"

    set -ga extended-keys always
  '';

  vim-pane-navigation = ''
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

    bind -Tpane-navigation h if-shell "$is_vim" 'send-keys C-w h' { if -F '#{pane_at_left}' "" 'select-pane -L' }
    bind -Tpane-navigation C-h if-shell "$is_vim" 'send-keys C-w h' { if -F '#{pane_at_left}' "" 'select-pane -L' }
    bind -Tpane-navigation j if-shell "$is_vim" 'send-keys C-w j' { if -F '#{pane_at_bottom}' "" 'select-pane -D' }
    bind -Tpane-navigation C-j if-shell "$is_vim" 'send-keys C-w j' { if -F '#{pane_at_bottom}' "" 'select-pane -D' }
    bind -Tpane-navigation k if-shell "$is_vim" 'send-keys C-w k' { if -F '#{pane_at_top}' "" 'select-pane -U' }
    bind -Tpane-navigation C-k if-shell "$is_vim" 'send-keys C-w k' { if -F '#{pane_at_top}' "" 'select-pane -U' }
    bind -Tpane-navigation l if-shell "$is_vim" 'send-keys C-w l' { if -F '#{pane_at_right}' "" 'select-pane -R' }
    bind -Tpane-navigation C-l if-shell "$is_vim" 'send-keys C-w l' { if -F '#{pane_at_right}' "" 'select-pane -R' }

    bind -Tpane-navigation s if-shell "$is_vim" 'send-keys C-w s' 'split-window'
    bind -Tpane-navigation C-s if-shell "$is_vim" 'send-keys C-w s' 'split-window'
    bind -Tpane-navigation v if-shell "$is_vim" 'send-keys C-w v' 'split-window -h'
    bind -Tpane-navigation C-v if-shell "$is_vim" 'send-keys C-w v' 'split-window -h'

    bind -Tpane-navigation q if-shell "$is_vim" 'send-keys C-w q' 'confirm-before -p "kill-pane #P? (y/n)" kill-pane'
    bind -Tpane-navigation C-q if-shell "$is_vim" 'send-keys C-w q' 'confirm-before -p "kill-pane #P? (y/n)" kill-pane'

    bind -Tcopy-mode-vi 'C-w' switch-client -Tpane-navigation
    bind -Troot C-w switch-client -Tpane-navigation
  '';

  vim-copy-mode = ''
    bind v copy-mode
    bind C-v copy-mode

    bind -Tcopy-mode-vi v send-keys -X begin-selection
    bind -Tcopy-mode-vi y send-keys -X copy-pipe-and-cancel
  '';

  window-movements = ''
    # Allow keeping Ctrl pressed with the defaults
    bind C-p previous-window
    bind C-n next-window

    bind h previous-window
    bind C-h previous-window
    bind l next-window
    bind C-l next-window
  '';
in {
  programs.tmux.extraConfig = lib.strings.concatStrings [
    advanced-keybinding-support

    vim-pane-navigation
    vim-copy-mode
    window-movements


    # Reload tmux config with <Prefix>R
    ''
      bind R source-file ${config.xdg.configHome}/tmux/tmux.conf
    ''
  ];
}
