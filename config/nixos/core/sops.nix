{
  config,
  inputs,
  lib,
  ...
}: let
  sopsFolder = lib.custom.relativeToRoot "secrets";
in {
  imports = [
    inputs.sops.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${sopsFolder}/secrets.yaml";
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/age/keys.txt";
      generateKey = true;
    };

    secrets = {
      github-token = {
        sopsFile = "${sopsFolder}/access-tokens.yaml";
      };
    };
  };
}
