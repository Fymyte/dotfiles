{
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  systems,
}: let
  nixpkgs-unstable-overlay = final: prev: {
    unstable = import nixpkgs-unstable {
      inherit prev;
      inherit (prev) system;
      config.allowUnfree = true;
    };
  };

  pkgsForSystem = system:
    import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [nixpkgs-unstable-overlay];
    };

  helpers = rec {
    default-system = "x86_64-linux";

    /*
      *
    Return an attribute set for every valid systems.
    The list of systems comes from ./systems.nix.

    # Type

    ```
    forAllSystems :: {pkgs = AttrSet; system = String } -> AttrSet
    ```

    # Examples
    :::{.example}
    ## `forAllSystems` usage example

    ```nix
    formatter = forAllSystems ({pkgs, system}: pkgs.alejandra)
    => { "x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra; "aarch64-linux" = ... }
    ```
    */
    forAllSystems = with builtins;
      f:
        listToAttrs (map (system: {
            name = system;
            value = f {
              inherit system;
              pkgs = pkgsForSystem system;
            };
          })
          (import systems));

    mkHomeConfig = {
      system ? default-system,
      modules ? [],
    }:
      home-manager.lib.homeManagerConfiguration {
        modules =
          [
            # Entry point for my config
            ../home.nix

            # All my custom home-manager modules
            ../modules/home-manager
          ]
          ++ modules;

        pkgs = pkgsForSystem system;
        extraSpecialArgs = {
          inherit inputs helpers;
          secrets = import ../secrets {inherit inputs;};
        };
      };
  };
in
  helpers
