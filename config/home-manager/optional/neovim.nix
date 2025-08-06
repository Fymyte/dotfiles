{ pkgs, ... }:
{
  stylix.targets.neovim.enable = false;

  home.packages = [
    pkgs.ruff
  ];

  programs.neovim = {
    package = pkgs.unstable.neovim-unwrapped;
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs.unstable; [
      tree-sitter
      # Neovim tools
      # TODO: move to separate file
      nixfmt-rfc-style
      yaml-language-server
      lua-language-server
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

      (pkgs.python3.withPackages (
        p:
        (with p; [
          python-lsp-server
          python-lsp-server.optional-dependencies
          pylsp-mypy
          pylsp-rope
          pyls-isort
        ])
      ))
    ];
  };
}
