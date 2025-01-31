{...}: let
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

    bind -Tpane-navigation C-v if-shell "$is_vim" 'send-keys C-w v' 'split-window -h'

    bind -Tcopy-mode-vi 'C-w' switch-client -Tpane-navigation
    bind -Troot C-w switch-client -Tpane-navigation
  '';

  vim-copy-mode = ''
      bind v copy-mode
      bind C-v copy-mode

      bind -Tcopy-mode-vi v send-keys -X begin-selection
      bind -Tcopy-mode-vi y send-keys -X copy-pipe-and-cancel
    '';
in {
  programs.tmux.extraConfig =
    vim-pane-navigation
    + vim-copy-mode;
}
