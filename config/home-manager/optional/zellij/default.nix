{...}: {
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  stylix.targets.zellij.enable = true;
  programs.zellij = {
    enable = true;
  };
}
