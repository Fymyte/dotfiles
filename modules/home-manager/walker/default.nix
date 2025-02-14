{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  nix.settings = {
    substituters = lib.mkAfter [
      "https://walker.cachix.org"
      # "https://walker-git.cachix.org"
    ];
    trusted-public-keys = lib.mkAfter [
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      # "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    ];
  };

  programs.walker.enable = true;
  programs.walker = {
    runAsService = true;
  };

  home.packages = [pkgs.unstable.libqalculate];
}
