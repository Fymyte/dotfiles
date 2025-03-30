{
  pkgs,
  config,
  lib,
  ...
}: {
  # Additional fonts
  home.packages = [
    pkgs.unstable.nerd-fonts.symbols-only
    pkgs.noto-fonts-color-emoji
  ];

  programs.ghostty.enable = true;
  programs.ghostty = {
    package = config.lib.nixGL.wrap pkgs.unstable.ghostty;
    enableFishIntegration = true;

    settings = {
      font-family = [
        config.preferences.font.monospace.name
        "Nerd Font Symbols"
        "Noto Color Emoji"
      ];
      theme = "catppuccin-mocha";
      font-size = config.preferences.terminal.font-size;

      command = config.preferences.terminal.command;
    };
  };
}
