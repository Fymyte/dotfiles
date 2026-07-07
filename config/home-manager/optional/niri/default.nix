{...}: {
  programs.niri = {
    enable = true;
    config = builtins.readFile ./config.kdl;
  };
}
