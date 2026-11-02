{
  pkgs,
  config,
  lib,
  ...
}: let
  editorcmd = "_nvim_wait";
  nvim-wait = pkgs.writeShellScriptBin editorcmd ''exec nvim --cmd 'let g:flatten_wait=1' "$@"'';
  ghosttyMimeTypes = [
    "text/plain"
    "text/markdown"
    "application/yaml"
    "application/toml"
    "application/x-shellscript"
    "text/x-csrc"
    "text/x-chdr"
    "text/x-python"
  ];
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
      ghostscript
      basedpyright
    ];
  };

  home.sessionVariables = {
    EDITOR = editorcmd;
    VISUAL = editorcmd;
  };

  # GLib before 2.80 picks the terminal for Terminal=true entries from a fixed
  # list without ghostty, and Debian ships 2.74. Launch ghostty directly instead
  xdg.desktopEntries.nvim-ghostty = lib.mkIf config.programs.ghostty.enable {
    name = "Neovim (Ghostty)";
    exec = "${lib.getExe config.programs.ghostty.package} -e ${lib.getExe config.programs.neovim.finalPackage} %F";
    terminal = false;
    noDisplay = true;
    mimeType = ghosttyMimeTypes;
  };

  # Not xdg.mimeApps, so apps can still write to mimeapps.list
  home.activation.nvimGhosttyMimeDefault = lib.mkIf config.programs.ghostty.enable (
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      run ${pkgs.xdg-utils}/bin/xdg-mime default nvim-ghostty.desktop ${lib.escapeShellArgs ghosttyMimeTypes}
    ''
  );
}
