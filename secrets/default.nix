{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  # NOTE: the import of the sops module must be done in
  # the host specific config file
  sops = {
    defaultSopsFile = ./secrets.yaml;

    secrets = {
      github-token = {
        sopsFile = ./access-tokens.yaml;
      };
    };
  };

  home.packages = [pkgs.sops];
}
