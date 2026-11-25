{pkgs, ...}: let
  # TODO: drop the patch once upstream stops its URL detection from replacing the OSC 8
  # links an application sets. It cuts long links that nvim wraps in a split
  zellij = pkgs.unstable.zellij.override {
    zellij-unwrapped = pkgs.unstable.zellij-unwrapped.overrideAttrs (old: {
      patches = (old.patches or []) ++ [./osc8-link-detection.patch];
    });
  };
  tab-switcher = pkgs.writeShellApplication {
    name = "zellij_tab_switcher";
    runtimeInputs = [zellij pkgs.fzf pkgs.jq];
    text = builtins.readFile ./tab-switcher.sh;
  };
in {
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  xdg.configFile."zellij/themes/custom-catppuccin-mocha-peach.kdl".source = ./theme.kdl;
  # Disable stylix and use my own fixed theme for now
  stylix.targets.zellij.enable = false;
  programs.zellij = {
    enable = true;
    package = zellij;
  };

  home.packages = [
    tab-switcher
  ];
}
