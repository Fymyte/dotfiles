{pkgs, ...}: {
  imports = [
    
  ];

  preferences.terminal = {
    font-size = 14;
    command = "${pkgs.tmux}/bin/tmux";
  };

  preferences.font.monospace = {
    package = pkgs.cascadia-code;
    name = "Cascadia Code";
  };
}
