{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak

    # Auto enable flatpak when selecting this browser
    ./services/flatpak.nix
  ];

  services.flatpak = {
    packages = [
      "app.zen_browser.zen"
    ];

    overrides."app.zen_browser.zen".Context = {
      # Expose directories for native messaging host extensions.
      # For example: running tridactyls' `nativeinstall` actually works
      filesystems = [
        "~/.mozilla"
        "~/.config/tridactyl"
        "~/.local/share/tridactyl/:ro"
      ];
    };
  };

  # Already give the webextensions permission for tridactyl native-messenger in zen_browser
  system.userActivationScripts.setup-tridactyl-webextension-permission.text = ''
    ${pkgs.flatpak}/bin/flatpak permission-set webextensions tridactyl app.zen_browser.zen yes
  '';
}
