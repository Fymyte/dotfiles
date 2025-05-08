{config, pkgs, ...}: {
  # Only show plymouth
  boot = {
    consoleLogLevel = 0;
    kernelParams = ["quiet"];

    plymouth = {
      enable = true;
      theme = "circuit";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [config.boot.plymouth.theme];
        })
      ];
    };
  };
}
