{...}: {
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  programs.zellij = {
    enable = true;
  };
}
