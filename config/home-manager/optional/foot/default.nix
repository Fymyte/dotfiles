{
  config,
  pkgs,
  ...
}: {
  imports = [./catppuccin-mocha.nix];

  # stylix.targets.foot.enable = false;

  programs.foot = {
    enable = true;
    package = pkgs.foot;
    server.enable = false;
    settings = {
      main = {
        shell = config.preferences.terminal.command;
        # font =
        #   "${config.preferences.font.monospace.name}:size=${builtins.toString (config.preferences.terminal.font-size - 6)}"
        #   + ",Nerd Font Symbols"
        #   + ",Noto Color Emoji";
      };

      scrollback.lines = 100000;
      cursor.style = "block";

      mouse = {
        hide-when-typing = true;
      };

      key-bindings = {
        show-urls-launch = "Control+Shift+u";
        unicode-input = "Control+Shift+semicolon";
      };
    };
  };
}
