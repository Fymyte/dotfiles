{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak.enable = true;
  services.flatpak = {
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    overrides.global = {
      Context.filesystems = [
        "~/.icons:ro"
        "~/.themes:ro"
      ];
    };
  };
}
