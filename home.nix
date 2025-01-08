# Default configuration, common to every users/hosts
{
  lib,
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

    # Misc
    ./modules/home-manager/git
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Make sure GNU coreutils are always present
    coreutils

    libqalculate
  ];

  # Import my neovim config from raw lua for now
  # home.file.".config/nvim".source = pkgs.fetchFromGitHub {
  #   owner = "fymyte";
  #   repo = "nvim-config";
  #   rev = "43928f78a4b0205b03996b43ae54ff75088566a1";
  #   hash = "sha256-L4Fgowx45DgxQlnoKKSw+/886XqbK0gw4YeSK5kzQKQ=";
  # };

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
    TERMINAL = "foot";
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

  # Do not change
  home.stateVersion = "24.05";
}
