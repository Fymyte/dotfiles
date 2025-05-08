{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  imports = [
    ./terminal.nix
  ];
}
