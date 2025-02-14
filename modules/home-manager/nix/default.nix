{
  inputs,
  pkgs,
  ...
}: {
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];

    settings.substituters = ["https://cache.nixos.org/" "https://nix-community.org/cache/"];
    settings.trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
  };
}
