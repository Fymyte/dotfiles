# Default configuration, common to every users/hosts
{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./secrets
    ./config/home-manager
  ];

  home.packages = [
    # Make sure GNU coreutils are always present
    pkgs.coreutils

    # Use nvim as pager
    pkgs.page

    pkgs.qmk

    pkgs.ripgrep
    pkgs.fd

    pkgs.which
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.sessionVariables = {
    # TODO: make this dependent on the current desktop env (dont want this set inside kde)
    QT_QPA_PLATFORMTHEME = "qt5ct";
    MAKEFLAGS = "$MAKEFLAGS --no-print-directory -j$(nproc)";
  };

  home.shellAliases = {
    dc = "docker compose";
    vim = "nvim";
    gl = "glab";
    g = "git";
    ga = "git add";
    gc = "git commit";
  };
}
