{
  description = "Fymyte's dotfiles";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-24.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # Keyboard remapping software
    kmonad.url = "github:kmonad/kmonad?dir=nix";
    kmonad.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";

    # Declarative flatpak installation (not idempotent)
    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

    # For the home-manager module
    walker.url = "github:abenz1267/walker";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";

    systems.url = "path:./systems.nix";
    systems.flake = false;
  };

  outputs = inputs: let
    callPackage = inputs.nixpkgs.lib.callPackageWith inputs;
    helpers = callPackage ./lib/helpers.nix {inherit inputs;};
  in {
    homeConfigurations = {
      "pguillaume@snorlax" = helpers.mkHomeConfig {
        modules = [
          # TODO: separate host config from here
          # Snorlax is not nixos, but still has some specific hm config
          ./hosts/snorlax
          ./users/work/sequans.nix
        ];
      };

      "fymyte@BOB" = helpers.mkHomeConfig {
        modules = [
          ./users/fymyte.nix

          ./config/home-manager/gaming.nix
        ];
      };

      "fymyte@pipoupc" = helpers.mkHomeConfig {
        modules = [
          ./users/fymyte.nix
        ];
      };
    };

    formatter = helpers.forAllSystems ({pkgs, ...}: pkgs.alejandra);
  };
}
