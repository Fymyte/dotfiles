{pkgs, ...}: {
  imports = [./catppuccin-mocha.nix];

  programs.foot = {
    enable = true;
    package = pkgs.unstable.foot;
    server.enable = false;
    settings = {
      main = {
        font = "Cascadia Code:size=8,Nerd Font Symbols,Noto Color Emoji";
        dpi-aware = true;
      };

      scrollback.lines = 100000;
      cursor.style = "block";

      mouse = {
        hide-when-typing = true;
      };

      key-bindings = {
        show-urls-launch = "Control+Shift+u";
      };
    };
  };
}
