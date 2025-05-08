{inputs}: let
  customPackagesOverlay = final: prev: (prev.lib.packagesFromDirectoryRecursive {
    callPackage = prev.lib.callPackageWith final;
    directory = ../pkgs;
  });
in {
  inherit customPackagesOverlay;

  default = final: prev: (customPackagesOverlay final prev);

  nixpkgs-unstable = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit prev;
      inherit (prev) system;
      config.allowUnfree = true;
    };
  };
}
