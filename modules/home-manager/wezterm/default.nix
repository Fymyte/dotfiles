{config, ...}: {
  programs.wezterm = {
    enable = false;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  # home.file."${config.xdg.configHome}/wezterm/wezterm.lua".source = ./wezterm.lua;
}
