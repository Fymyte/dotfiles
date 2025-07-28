{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  programs.walker.enable = true;
  programs.walker = {
    package = pkgs.unstable.walker;
    runAsService = true;
  };

  home.packages = [pkgs.libqalculate];
}
