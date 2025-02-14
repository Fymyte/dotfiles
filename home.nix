# Default configuration, common to every users/hosts
{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Secrets management
    ./modules/home-manager/sops

    # Styling
    ./modules/home-manager/stylix
    ./modules/home-manager/waybar
    ./modules/home-manager/nix

    # Editor(s)
    ./modules/home-manager/neovim

    # Browser(s)
    ./modules/home-manager/firefox

    # Shell(s)
    ./modules/home-manager/bash
    ./modules/home-manager/fish
    ./modules/home-manager/nushell

    # Shell tools
    ./modules/home-manager/eza

    # Terminal(s)
    ./modules/home-manager/kitty
    ./modules/home-manager/wezterm
    ./modules/home-manager/foot
    ./modules/home-manager/ghostty
    ./modules/home-manager/zellij
    ./modules/home-manager/tmux

    # Misc
    ./modules/home-manager/git
    ./modules/home-manager/screenshot
    ./modules/home-manager/walker
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    # Make sure GNU coreutils are always present
    pkgs.coreutils

    pkgs.libqalculate

    # Use nvim as pager
    pkgs.page

    pkgs.qmk
  ];

  programs.btop.enable = true;
  programs.btop.settings = {
    color_theme = "TTY";
    theme_background = false;
  };

  programs.fzf.enable = true;

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.local/cargo/bin" # Packages installed using `cargo install <package>`
  ];

  home.sessionVariables = {
    # TODO: make this dependent on the current desktop env (dont want this set inside kde)
    QT_QPA_PLATFORMTHEME = "qt5ct";
    MAKEFLAGS = "$MAKEFLAGS --no-print-directory -j$(nproc)";
    PAGER = "${pkgs.page}/bin/page -WfC -q 90000 -z 90000";
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

  # Do not change
  home.stateVersion = "24.05";
}
