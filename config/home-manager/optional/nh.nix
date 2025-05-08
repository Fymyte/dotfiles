{lib, ...}: {
  programs.nh = {
    enable = true;
    flake = lib.custom.relativeToRoot ".";
  };
}
