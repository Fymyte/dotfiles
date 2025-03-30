{...}: {
  programs.waybar.enable = false;
  programs.waybar = {
    style = ./catppuccin-mocha.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "DP-7"
        ];
        modules-left = ["sway/workspaces" "sway/mode" "wlr/taskbar"];
        modules-center = ["sway/window"];
        modules-right = ["mpd" "custom/mymodule#with-css-id" "clock"];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
      };
    };
  };
}
