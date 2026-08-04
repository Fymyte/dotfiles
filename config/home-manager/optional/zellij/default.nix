{pkgs, ...}: let
  tab-switcher = pkgs.writeShellApplication {
    name = "zellij_tab_switcher";
    runtimeInputs = [pkgs.zellij pkgs.fzf pkgs.jq];
    text = builtins.readFile ./tab-switcher.sh;
  };
in {
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  xdg.configFile."zellij/themes/custom-catppuccin-mocha-peach.kdl".source = ./theme.kdl;
  # Disable stylix and use my own fixed theme for now
  stylix.targets.zellij.enable = false;
  programs.zellij = {
    enable = true;
  };

  home.packages = [
    tab-switcher
  ];
}
