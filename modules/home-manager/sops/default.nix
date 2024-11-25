{
  lib,
  config,
  inputs,
  ...
}: let
  sops-secret-path = ../../../secrets;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    defaultSopsFile = lib.mkDefault "${sops-secret-path}" /secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "${config.home.homeDirectory}/.ssh/id_ed25519"
      ];
      keyFile = "${config.xdg.configHome}/age/key.txt";
      generateKey = true;
    };
  };
}
