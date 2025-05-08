{lib, ...}: {
  services.flatpak = {
    enable = true;

    # Don't override flathub remote, simply append the beta channel
    remotes = lib.mkOptionDefault [
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
  };
}
