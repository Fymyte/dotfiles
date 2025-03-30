{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  imports = [
    ./font.nix
    ./terminal.nix
  ];
}
