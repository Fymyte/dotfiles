{...}: {
  imports = [./.];

  services.flatpak = {
    packages = [
      "org.videolan.VLC"
    ];
  };
}
