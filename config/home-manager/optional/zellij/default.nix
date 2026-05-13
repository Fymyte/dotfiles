{...}: {
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  xdg.configFile."zellij/themes/custom-catppuccin-mocha-peach.kdl".source = ./theme.kdl;
  # Disable stylix and use my own fixed theme for now
  stylix.targets.zellij.enable = false;
  programs.zellij = {
    enable = true;
  };
}
