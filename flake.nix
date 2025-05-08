{
  description = "Fymyte's dotfiles";

  nixConfig = {
    extra-substituers = [ "https://fymyte.cachix.org"];
    extra-trusted-public-key = ["fymyte.cachix.org-1:RnotB2Ob0moe5UuXtvg1iIjTzgiy3x0FMgZYpa/DnGE="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-24.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";

    # Declarative flatpak installation (not idempotent)
    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

    # For the home-manager module
    walker.url = "github:abenz1267/walker";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    overlays = import ./overlays {inherit inputs;};
    lib = nixpkgs.lib.extend (self: super: {
      custom = import ./lib {
        inherit (nixpkgs) lib;
      };
      hm = home-manager.lib.hm;
    });

    systems = {
      x86_64-linux = "x86_64-linux";
    };

    supportedSystems = [systems.x86_64-linux];
    defaultSystem = systems.x86_64-linux;

    pkgsForSystem = system:
      import nixpkgs {
        inherit system lib;
        config.allowUnfree = true;
        overlays = [overlays.nixpkgs-unstable overlays.default];
      };

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    packages = forAllSystems (system:
      nixpkgs.lib.packagesFromDirectoryRecursive {
        callPackage = nixpkgs.lib.callPackageWith (pkgsForSystem system);
        directory = ./pkgs;
      });
  in {
    inherit overlays packages;

    # One config for each `./home/<user>/<host>`
    homeConfigurations = builtins.listToAttrs (lib.flatten (map (user: (map (host: {
        name = "${user}@${host}";
        value = home-manager.lib.homeManagerConfiguration {
          modules = [({...}: {home.username = user;}) ./home/${user}/${host}];
          extraSpecialArgs = {inherit inputs outputs lib;};
          # TODO: Find how to set system per home config
          pkgs = pkgsForSystem defaultSystem;
        };
      })
      (builtins.attrNames (builtins.readDir ./home/${user}))))
    (builtins.attrNames (builtins.readDir ./home))));

    #   "fymyte@pipoupc" = mkHomeConfig {
    #     modules = [
    #       ./users/fymyte.nix
    #     ];
    #   };
    # };

    # One config for each `./hosts/nixos/<host>`
    nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          modules = [./hosts/nixos/${host}];
          specialArgs = {inherit inputs outputs lib;};
        };
      })
      (builtins.attrNames (builtins.readDir ./hosts/nixos)));

    formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.alejandra);
  };
}
