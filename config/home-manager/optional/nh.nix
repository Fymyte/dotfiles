{config, lib, ...}: {
  programs.nh = {
    enable = true;
    flake = "${config.xdg.configHome}/dotfiles";
  };
}
