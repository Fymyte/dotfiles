{pkgs, ...}: {
  # NOTE: don't use the NixOS configuration option as I don't want to override the user's config
  # Also use latest stable version of neovim available
  environment.systemPackages = [pkgs.unstable.neovim pkgs.unstable.page pkgs.gcc pkgs.gnumake];
  environment.variables.EDITOR = "nvim";
}
