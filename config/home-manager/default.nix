{...}: {
  imports = [
    ./preferences
    ./theming/stylix

    ./terminals/foot
    ./terminals/ghostty
    ./terminals/kitty
    ./terminals/tmux
    ./terminals/wezterm
    ./terminals/zellij

    ./shells/bash
    ./shells/fish

    ./applications/btop
    ./applications/eza
    ./applications/fzf
    ./applications/git
    ./applications/neovim
    ./applications/nix
    ./applications/page
    ./applications/screenshot
    ./applications/walker
    ./applications/waybar


    # Applications packages via flatpaks
    ./applications/flatpaks
    ./applications/flatpaks/firefox
    ./applications/flatpaks/zen
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
