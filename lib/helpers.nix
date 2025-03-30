{inputs, ...}: let
  module = rec {
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

    mkHomeConfig = {...} @ args:
      inputs.home-manager.lib.homeManagerConfiguration {
        modules =
          [
            # Entry point for my config
            ../home.nix

            # All my custom home-manager modules
            ../modules/home-manager
          ]
          ++ (args.modules or []);

        pkgs = pkgsForSystem (args.system or "x86_64-linux");
        extraSpecialArgs =
          (args.extraSpecialArgs or {})
          // {
            inherit inputs;
          };
      };
  };
in
  module
