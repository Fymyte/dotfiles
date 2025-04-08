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
    "${config.home.homeDirectory}/.local/cargo/bin" # Packages installed using `cargo install <package>`
  ];

  home.sessionVariables = {
    # TODO: make this dependent on the current desktop env (dont want this set inside kde)
    QT_QPA_PLATFORMTHEME = "qt5ct";
    MAKEFLAGS = "$MAKEFLAGS --no-print-directory -j$(nproc)";
    PAGER = "${pkgs.page}/bin/page -WC -q 99999 -z 99999";
    MANPAGER = "${pkgs.page}/bin/page -t man";
  };

  home.shellAliases = {
    dc = "docker compose";
    vim = "nvim";
    gl = "glab";
    g = "git";
    ga = "git add";
    gc = "git commit";

    # Not converted to fish abbreviations
    page = config.home.sessionVariables.PAGER;
    less = config.home.sessionVariables.PAGER;
  };
}
