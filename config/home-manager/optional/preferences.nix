{pkgs, ...}: {
  preferences.terminal = {
    command = "${pkgs.tmux}/bin/tmux";
  };
}
