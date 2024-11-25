{pkgs, ...}: {
  home.packages = with pkgs; [
    # Neovim tools
    # TODO: move to separate file
    nixfmt-rfc-style
    yaml-language-server
    nixd
    alejandra
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
