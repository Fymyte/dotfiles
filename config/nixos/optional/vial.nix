{pkgs, ...}: {
  services.udev.packages = with pkgs; [
    qmk
    qmk-udev-rules
    qmk_hid
    vial
    via
  ];
}
