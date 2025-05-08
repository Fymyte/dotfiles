{
  config,
  pkgs,
  lib,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Programs I always expect to be present
  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.which
  ];

  home.homeDirectory = lib.mkDefault "/home/${config.home.username}/";

  # All new home-manager config will keep 24.05 layout
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
