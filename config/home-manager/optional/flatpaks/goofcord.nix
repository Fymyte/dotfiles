{...}: {
  imports = [./.];

  services.flatpak = {
    packages = [
      "io.github.milkshiift.GoofCord"
    ];
  };
}
