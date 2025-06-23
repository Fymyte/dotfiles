{pkgs, ...}: {
  imports = [./plugins.nix ./keymaps.nix];
  programs.tmux.enable = true;
  programs.tmux = {
    package = pkgs.unstable.tmux;
    sensibleOnTop = false;
    escapeTime = 0;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    newSession = false;
    aggressiveResize = true;
    keyMode = "vi";
    shortcut = "Space";
    historyLimit = 100000;
    terminal = "tmux-256color";

    shell = "${pkgs.fish}/bin/fish";

    extraConfig = ''
      set -g focus-event on
      set -g status-interval 5
    '';
  };
}
