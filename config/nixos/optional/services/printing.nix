{pkgs, ...}: {
  services.printing.enable = true;
  services.printing = {
    browsed.enable = false;
    drivers = [pkgs.epson-escpr];
  };

  services.avahi.enable = true;
}
