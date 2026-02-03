{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.modules) mkMerge;
in {
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      providers = {
        default = ["desktopapplications"];
      };
    };
  };
}
