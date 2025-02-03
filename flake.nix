{
  description = "Fymyte's dotfiles";

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

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {home-manager, ...} @ inputs: let
    # Get packages for given system (x86_64-linux, ...)
    pkgsForSystem = system:
      import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit prev;
              inherit system;
              config.allowUnfree = true;
            };
          })
        ];
      };

    mkHomeConfig = {extraSpecialArgs, ...} @ args:
      home-manager.lib.homeManagerConfiguration {
        modules = [./home.nix] ++ (args.modules or []);
        pkgs = pkgsForSystem (args.system or "x86_64-linux");
        extraSpecialArgs = extraSpecialArgs // {inherit inputs;};
      };
  in {
    homeConfigurations = {
      "pguillaume@snorlax" = mkHomeConfig {
        modules = [
          # TODO: separate host config from here
          # Snorlax is not nixos, but still have some specific hm config
          ./hosts/snorlax
          ./users/work/sequans.nix
        ];
        extraSpecialArgs = {};
      };

      "fymyte@BOB" = mkHomeConfig {
        modules = [
          ./users/fymyte.nix

          ./modules/home-manager/protonup
        ];
        extraSpecialArgs = {};
      };
    };

    formatter = {
      name = "alejandra";
    };
  };
}
