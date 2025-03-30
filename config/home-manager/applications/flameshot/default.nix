{
  config,
  pkgs,
  ...
}: {
  services.flameshot.enable = true;
  services.flameshot = {
    package = pkgs.unstable.flameshot;
    settings = {
      General = {
        SavePath = "${config.home.homeDirectory}/Pictures";
        uiColor = "#fab387";
      };
    };
  };
}
