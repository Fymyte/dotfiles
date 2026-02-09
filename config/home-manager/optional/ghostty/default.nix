{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      font-family = [
        config.stylix.fonts.monospace.name
        "Nerd Font Symbols"
        config.stylix.fonts.emoji.name
      ];
      theme = "Catppuccin Mocha";
      font-size = config.stylix.fonts.sizes.terminal;

      command = config.preferences.terminal.command;
    };
  };
}
