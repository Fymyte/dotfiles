{
  config,
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
      "config/home-manager/optional/wezterm"
      "config/home-manager/optional/tmux"
      "config/home-manager/optional/neovim.nix"
      "config/home-manager/optional/page.nix"
      "config/home-manager/optional/walker.nix"
      "config/home-manager/optional/btop.nix"
      "config/home-manager/optional/fzf.nix"
      "config/home-manager/optional/eza.nix"
      "config/home-manager/optional/git.nix"
      "config/home-manager/optional/nh.nix"

      "config/home-manager/optional/flatpaks/zen.nix"
    ])
  ];

  hostSpec = {
    username = config.home.username;
    userFullName = "Pierrick Guillaume";
    home = config.home.homeDirectory;
    hostName = "pipoupc";
    handle = "Fymyte";
    isServer = false;
    headless = false;
  };

  accounts.email.accounts = {
    Gmail = {
      realName = "Pierrick Guillaume";
      address = "pguillaume@fymyte.com";
      flavor = "gmail.com";
      primary = true;
    };

    pierguill = {
      realName = "Pierrick Guillaume";
      address = "pierguill@gmail.com";
    };
  };
}
