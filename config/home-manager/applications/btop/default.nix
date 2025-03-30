{...}: {
  programs.btop.enable = true;
  programs.btop.settings = {
    color_theme = "TTY";
    theme_background = false;
  };
}
