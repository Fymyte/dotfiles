{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  sopsFolder = lib.custom.relativeToRoot "secrets";
in {
  imports = [
    inputs.sops.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = "${sopsFolder}/secrets.yaml";
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

    secrets = {
      github-token = {
        sopsFile = "${sopsFolder}/access-tokens.yaml";
      };
    };
  };

  home.packages = [
    pkgs.sops
    pkgs.age
  ];
}
