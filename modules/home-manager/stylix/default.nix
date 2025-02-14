{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  icon-theme = rec {
    name = "Colloid-Yellow-Catppuccin";
    package = (
      pkgs.colloid-icon-theme.override {
        schemeVariants = ["catppuccin"];
        colorVariants = ["yellow"];
      }
    );
    # TODO: how can we remove the '-Dark' at the end and still keep the dark variant
    package-icon-directory = "${package}/share/icons/${name}-Dark";
  };
in {
  imports = [inputs.stylix.homeManagerModules.stylix];
  stylix = {
    enable = true;
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
    autoEnable = false;
  };

  gtk.iconTheme = {
    enable = true;
    name = icon-theme.name;
    package = icon-theme.package;
  };

  qt = {
    platformTheme.name = "qtct";
    style.name = "breeze";
  };

  # Actually creates the necessary links to generated icons in XDG's standards directories
  home.file."${config.home.homeDirectory}/.icons/${icon-theme.name}".source = icon-theme.package-icon-directory;
  home.file."${config.xdg.dataHome}/icons/${icon-theme.name}".source = icon-theme.package-icon-directory;
}
