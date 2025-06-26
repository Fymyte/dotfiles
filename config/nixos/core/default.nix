{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  platform = "nixos";
in {
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops.nixosModules.sops

    (map lib.custom.relativeToRoot [
      "modules/${platform}"

      "config/nixos/users"

      "config/nixos/core/nix.nix"
      "config/nixos/core/neovim.nix"
      "config/nixos/core/sops.nix"
      "config/nixos/core/${platform}.nix"
    ])
  ];

  hostSpec = {
    username = lib.mkDefault "fymyte";
    handle = lib.mkDefault "Fymyte";
    userFullName = lib.mkDefault "Pierrick Guillaume";
  };

  networking.hostName = config.hostSpec.hostName;

  # If there is a conflict file backed up, use this extension
  home-manager.backupFileExtension = "bak";

  # Bare minimum packages for every installs
  services.openssh.enable = true;
  programs.git.enable = true;

  environment.systemPackages = [pkgs.wget];
}
