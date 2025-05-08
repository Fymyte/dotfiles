{pkgs, ...}: {
  preferences.terminal = {
    font-size = 12;
    command = "${pkgs.tmux}/bin/tmux";
  };
}
