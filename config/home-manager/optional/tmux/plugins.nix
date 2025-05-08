{
  pkgs,
  lib,
  ...
}:
with pkgs.tmuxPlugins; let
  # Updated version of catppuccin/tmux, which is quite outdated in nixpkgs
  tmux-catppuccin = mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "2.1.2";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "2c4cb5a07a3e133ce6d5382db1ab541a0216ddc7";
      hash = "sha256-vBYBvZrMGLpMU059a+Z4SEekWdQD0GrDqBQyqfkEHPg=";
    };
  };

  tmux-nvim = mkTmuxPlugin {
    pluginName = "tmux.nvim";
    version = "2024-10-25";
    src = pkgs.fetchFromGitHub {
      owner = "aserowy";
      repo = "tmux.nvim";
      rev = "307bad95a1274f7288aaee09694c25c8cbcd6f1a";
      hash = "sha256-c/1swuJ6pIiaU8+i62Di/1L/b4V9+5WIVzVVSJJ4ls8=";
    };
  };
  tmux-resurrect = mkTmuxPlugin {
    pluginName = "resurrect";
    version = "unstable-2023-03-06";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-resurrect";
      rev = "cff343cf9e81983d3da0c8562b01616f12e8d548";
      hash = "sha256-dkiIbTPIn3ampK7LItndOL69cMVfuJyOIQZL4lt58jQ=";
    };
  };
in {
  programs.tmux.plugins = [
    tmux-catppuccin
    tmux-nvim

    tmux-resurrect
  ];
}
