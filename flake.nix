{
  description = "Fymyte's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Keyboard remapping software
    kmonad.url = "github:kmonad/kmonad?dir=nix";
    kmonad.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {home-manager, ...} @ inputs: let
    pkgs-stable = inputs.nixpkgs-stable;

    # Get packages for given system (x86_64-linux, ...)
    pkgsForSystem = system:
      import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    mkHomeConfig = {extraSpecialArgs, ...} @ args:
      home-manager.lib.homeManagerConfiguration (
        {
          modules =
            [
              ./home.nix
            ]
            ++ (args.modules or []);
          pkgs = pkgsForSystem (args.system or "x86_64-linux");
        }
        // {
          inherit extraSpecialArgs;
        }
        // {
          extraSpecialArgs = {
            inherit pkgs-stable;
            inherit inputs;
          };
        }
      );
  in {
    homeConfigurations = {
      "pguillaume@snorlax" = mkHomeConfig {
        modules = [
          ./hosts/snorlax
          ./users/work/sequans.nix
        ];
        extraSpecialArgs = {};
      };
    };

    formatter = {
      name = "alejandra";
    };
  };
}
