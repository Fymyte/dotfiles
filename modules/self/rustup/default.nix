{pkgs, ...}: {
  home.packages = [pkgs.rustup];

  # Manage toolchains using rustup
}
