{
  config,
  pkgs,
  ...
}: let
  primary =
    builtins.elemAt
    (builtins.filter
      (a: a.primary)
      (builtins.attrValues config.accounts.email.accounts))
    0;
in {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = primary.realName;
    userEmail = primary.address;

    ignores = [
      "compile_commands.json"
      ".gdbinit"
      "Sesssion.vim"
      ".session.vim"
      ".gitlab.nvim"
    ];

    extraConfig.credential.helper = ["cache --timeout 21600"];
  };

  programs.git-credential-oauth = {
    enable = true;
  };

  home.shellAliases = {
    gl = "glab";
    g = "git";
    ga = "git add";
    gc = "git commit";
  };

  home.packages = [pkgs.git-crypt pkgs.unstable.glab pkgs.unstable.gh];
}
