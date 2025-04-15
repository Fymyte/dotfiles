{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    tree-sitter
    # Neovim tools
    # TODO: move to separate file
    nixfmt-rfc-style
    yaml-language-server
    lua-language-server
    ruff
    vale
    nixd
    nil
    alejandra
    kdlfmt
    clang-tools
    stylua
    selene
    taplo

    harper

    nodePackages.vscode-json-languageserver
  ];

  programs.neovim = {
    package = pkgs.unstable.neovim-unwrapped;
    enable = true;
    defaultEditor = true;
  };
}
