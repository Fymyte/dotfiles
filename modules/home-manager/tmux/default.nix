{pkgs, ...}: {
  imports = [./plugins.nix ./keymaps.nix];
  programs.tmux.enable = true;
  programs.tmux = {
    package = pkgs.unstable.tmux;
    escapeTime = 0;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    newSession = true;
    keyMode = "vi";
    shortcut = "Space";
    historyLimit = 100000;
    terminal = "tmux-256color";

    extraConfig = ''
      set -ga terminal-overrides ",foot:Tc"

    '';
  };
}
