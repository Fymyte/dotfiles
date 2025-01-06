{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    # Neovim tools
    # TODO: move to separate file
    nixfmt-rfc-style
    yaml-language-server
    nixd
    alejandra
  ];

  programs.neovim = {
    package = pkgs.unstable.neovim-unwrapped;
    enable = true;
    defaultEditor = true;
  };
}
