{
  config,
  inputs,
  lib,
  ...
}: {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "config/home-manager/core"

      "config/home-manager/optional/preferences.nix"
      "config/home-manager/optional/stylix.nix"
      "config/home-manager/optional/gtk.nix"

      "config/home-manager/optional/fish"
      "config/home-manager/optional/bash.nix"
      "config/home-manager/optional/ghostty"
      "config/home-manager/optional/tmux"
      "config/home-manager/optional/zellij"
      "config/home-manager/optional/neovim.nix"
      "config/home-manager/optional/page.nix"
      "config/home-manager/optional/walker.nix"
      "config/home-manager/optional/btop.nix"
      "config/home-manager/optional/fzf.nix"
      "config/home-manager/optional/eza.nix"
      "config/home-manager/optional/git.nix"
      "config/home-manager/optional/nh.nix"

      "config/home-manager/optional/wl-clipboard.nix"
      "config/home-manager/optional/wlr-screenshot.nix"

      "config/home-manager/optional/flatpaks/zen.nix"
    ])
  ];

  home.homeDirectory = "/data/exports/users/pguillaume/";

  hostSpec = {
    username = config.home.username;
    userFullName = "Pierrick Guillaume";
    home = config.home.homeDirectory;
    hostName = "snorlax";
    handle = "pguillaume";
    isServer = false;
    headless = false;
  };

  accounts.email.accounts = {
    Sequans = {
      realName = "Pierrick Guillaume";
      address = "pguillaume@sequans.com";
      flavor = "outlook.office365.com";
      primary = true;
    };
  };

  stylix.targets.kde.enable = false;

  # This is not a nixos system
  targets.genericLinux.enable = true;

  # This is not a nixos system
  nixGL.packages = inputs.nixgl.packages;

  home.sessionVariables = {
    GL_HOST = "gitlab-shared.sequans.com";
  };

  sops = {
    defaultSymlinkPath = "/run/user/2246/sops-nix/secrets";
    defaultSecretsMountPoint = "/run/user/2246/sops-nix/secrets.d";
  };
}
