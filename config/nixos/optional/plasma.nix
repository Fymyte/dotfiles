{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = [
    pkgs.kdePackages.discover
  ];
}
