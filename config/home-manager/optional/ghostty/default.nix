{
  pkgs,
  config,
  lib,
  ...
}: {
  stylix.targets.ghostty.enable = false;
  home.packages = [pkgs.unstable.nerd-fonts.symbols-only];

  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.unstable.ghostty;
    enableFishIntegration = true;

    settings = {
      font-family = [
        config.stylix.fonts.monospace.name
        "Nerd Font Symbols"
        config.stylix.fonts.emoji.name
      ];
      theme = "catppuccin-mocha";
      font-size = config.stylix.fonts.sizes.applications;

      command = config.preferences.terminal.command;
    };
  };
}
