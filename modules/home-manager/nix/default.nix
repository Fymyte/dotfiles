{ inputs, ... }:{
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  # nix = {
  #   package = pkgs.nix;
  #   settings.experimental-features = [ "nix-command" "flakes" ];
  # };
}
