{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    protonup
    protonup-qt
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
  };
}
