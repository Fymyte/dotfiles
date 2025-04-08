{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    # Neovim tools
    # TODO: move to separate file
    nixfmt-rfc-style
    yaml-language-server
    lua-language-server
    ltex-ls-plus
    ruff
    vale
    nixd
    nil
    alejandra
    kdlfmt
    clang-tools
    stylua
    taplo

    harper
  ];

  # Symlink old binary name to new ltex-ls-plus executable
  home.file."${config.home.homeDirectory}/.local/bin/ltex-ls".source = "${pkgs.unstable.ltex-ls-plus}/bin/ltex-ls-plus";

  programs.neovim = {
    package = pkgs.unstable.neovim-unwrapped;
    enable = true;
    defaultEditor = true;
  };
}
