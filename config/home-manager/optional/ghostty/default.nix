{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.ghostty;
    enableFishIntegration = true;

    settings = {
      font-family = [
        config.stylix.fonts.monospace.name
        "Nerd Font Symbols"
        config.stylix.fonts.emoji.name
      ];
      theme = "catppuccin-mocha";
      font-size = config.stylix.fonts.sizes.terminal;

      command = config.preferences.terminal.command;
    };
  };
}
