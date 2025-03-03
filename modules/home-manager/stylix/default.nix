{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  iconTheme = rec {
    name = "Colloid-Yellow-Catppuccin";
    light = "${name}-Light";
    dark = "${name}-Dark";
    package = (
      pkgs.colloid-icon-theme.override {
        schemeVariants = ["catppuccin"];
        colorVariants = ["yellow"];
      }
    );
    packageIconDirectory = "${package}/share/icons/";
  };
in {
  imports = [inputs.stylix.homeManagerModules.stylix];
  stylix = {
    enable = true;
    polarity = "dark";
    image = lib.mkDefault ./wallpapers/japan-background-digital-art.jpg;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = lib.mkDefault {
      package = pkgs.catppuccin-cursors.mochaPeach;
      name = "catppuccin-mocha-peach-cursors";
      size = 24;
    };
    fonts = {
      serif = lib.mkDefault {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = lib.mkDefault {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = lib.mkDefault {
        package = pkgs.cascadia-code;
        name = "Cascadia Code";
      };
      emoji = lib.mkDefault {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    iconTheme = {
      enable = true;
      package = iconTheme.package;
      light = iconTheme.light;
      dark = iconTheme.dark;
    };
    autoEnable = false;

    targets = {
      gtk.enable = true;
      # gtk.flatpakSupport.enable = true;
      # Not supported in current stylix branch
      # qt.enable = true;
    };
  };

  qt = {
    platformTheme.name = "qtct";
    style.name = "breeze";
  };

  # Actually creates the necessary links to generated icons in XDG's standards directories
  home.file."${config.xdg.dataHome}/icons/${iconTheme.name}".source = "${iconTheme.packageIconDirectory}/${iconTheme.name}";
  home.file."${config.home.homeDirectory}/.icons/${iconTheme.name}".source = "${iconTheme.packageIconDirectory}/${iconTheme.name}";
  home.file."${config.xdg.dataHome}/icons/${iconTheme.light}".source = "${iconTheme.packageIconDirectory}/${iconTheme.light}";
  home.file."${config.home.homeDirectory}/.icons/${iconTheme.light}".source = "${iconTheme.packageIconDirectory}/${iconTheme.light}";
  home.file."${config.xdg.dataHome}/icons/${iconTheme.dark}".source = "${iconTheme.packageIconDirectory}/${iconTheme.dark}";
  home.file."${config.home.homeDirectory}/.icons/${iconTheme.dark}".source = "${iconTheme.packageIconDirectory}/${iconTheme.dark}";
}
