{
  pkgs,
  lib,
  ...
}: {
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

  # Allow tridactyl to run its native messenger
  home.activation.setup-tridactyl-webextension-permission = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ${pkgs.flatpak}/bin/flatpak permission-set webextensions tridactyl app.zen_browser.zen yes
  '';
}
