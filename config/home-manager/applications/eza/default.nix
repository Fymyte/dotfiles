{pkgs, ...}: {
  home.packages = with pkgs; [
    # ls replacement
    eza
  ];
  # Replace ls by eza by default
  home.shellAliases.ls = "eza -lh";
}
