{
  inputs,
  pkgs,
  lib,
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
      "config/nixos/optional/niri.nix"
      "config/nixos/optional/plasma.nix" # Keep plasma as backup for now
      # TODO: Remove xserver
      "config/nixos/optional/xserver.nix"
    ])
  ];

  hostSpec = {
    hostName = "microsnore";
    username = "pguillaume";
    handle = "Pierrick Guillaume";
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

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  networking = {
    networkmanager.enable = true;
    networkmanager.plugins = with pkgs; [networkmanager-openvpn];
    enableIPv6 = true;
  };

  programs.dconf.enable = true;

  # Hint Electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.fwupd.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
