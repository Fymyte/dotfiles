{pkgs, ...}: let
  editorcmd = "_nvim_wait";
  nvim-wait = pkgs.writeShellScriptBin editorcmd ''exec nvim --cmd 'let g:flatten_wait=1' "$@"'';
in {
  stylix.targets.neovim.enable = false;

  home.packages = [
    pkgs.ruff
    nvim-wait
  ];

  programs.neovim = {
    package = pkgs.unstable.neovim-unwrapped;
    enable = true;
    defaultEditor = false;
    withRuby = false;
    withPython3 = false;
    sideloadInitLua = true;

    extraPackages = with pkgs.unstable; [
      tree-sitter
      # Neovim tools
      # TODO: move to separate file
      nixfmt
      emmylua-ls
      yaml-language-server
      vale
      nixd
      nil
      alejandra
      kdlfmt
      clang-tools
      stylua
      selene
      taplo
      ltex-ls-plus

      harper

      vscode-json-languageserver

      imagemagick

      (pkgs.python3.withPackages (
        p: (with p; [
          python-lsp-server
          python-lsp-server.optional-dependencies
          pylsp-mypy
          pylsp-rope
          pyls-isort
        ])
      ))
      basedpyright
    ];
  };

  home.sessionVariables = {
    EDITOR = editorcmd;
    VISUAL = editorcmd;
  };
}
