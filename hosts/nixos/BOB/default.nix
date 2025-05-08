{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-cpu-amd-pstate
    inputs.hardware.nixosModules.common-cpu-amd-zenpower
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    inputs.hardware.nixosModules.gigabyte-b550

    (map lib.custom.relativeToRoot [
      "config/nixos/core"

      "config/nixos/optional/audio.nix"
      "config/nixos/optional/bluetooth.nix"
      "config/nixos/optional/plymouth.nix"
      "config/nixos/optional/logitech.nix"
      "config/nixos/optional/vial.nix"

      "config/nixos/optional/gaming.nix"
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
    hostName = "BOB";
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

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;
  services.xserver.videoDrivers = ["amdgpu"];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      amdvlk.enable = true;
    };
  };

  system.stateVersion = "24.11";
}
