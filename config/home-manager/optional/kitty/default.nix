{pkgs, ...}: {
  programs.kitty = {
    enable = false;
    font = {
      package = pkgs.cascadia-code;
      name = "Cascadia Code";
      size = 13;
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AA,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF,U+F0001-U+F1AF0 Symbols Nerd Font Mono";
      scrollback_pager = ''
        bash -c "exec nvim 63<&0 0</dev/null -u NONE -c 'map <silent> q :qa!<CR>' -c 'set shell=bash scrollback=100000 termguicolors laststatus=0 clipboard+=unnamedplus' -c 'autocmd TermEnter * stopinsert' -c 'autocmd TermClose * call cursor(max([0,INPUT_LINE_NUMBER-1])+CURSOR_LINE, CURSOR_COLUMN)' -c 'terminal sed </dev/fd/63 -e \"s/'$'\x1b'\']8;;file:[^\]*[\]//g\" && sleep 0.01 && printf \"'$'\x1b'\']2;\"'"
      '';
      kitty_mod = "ctrl+shift";
      window_margin_width = "5 5 5 5";
    };
  };
}
