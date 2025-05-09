{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    (map lib.custom.relativeToRoot [
      "config/nixos/core"

      "config/nixos/optional/audio.nix"
      "config/nixos/optional/bluetooth.nix"
      "config/nixos/optional/plymouth.nix"

      "config/nixos/optional/zen-browser.nix"

      "config/nixos/optional/services/printing.nix"
      "config/nixos/optional/services/flatpak.nix"
      "config/nixos/optional/services/sddm.nix"
      "config/nixos/optional/services/ssh.nix"

      "config/nixos/optional/hyprland.nix"
      "config/nixos/optional/plasma.nix" # Keep plasma as backup for now
      # TODO: Remove xserver
      "config/nixos/optional/xserver.nix"
    ])
  ];

  hostSpec = {
    hostName = "pipoupc";
    isNixOS = true;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = lib.mkDefault 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  boot.initrd = {
    systemd.enable = true;
    verbose = false;
  };

  environment.systemPackages = [pkgs.sbctl];

  boot.initrd.luks.devices."luks-a67c69ed-3bb7-49c1-8943-4b1808bf10f7".device = "/dev/disk/by-uuid/a67c69ed-3bb7-49c1-8943-4b1808bf10f7";

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  services.fwupd.enable = true;

  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
