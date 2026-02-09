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

    settings.user = {
      name = primary.realName;
      email = primary.address;
      credential.helper = ["cache --timeout 86400"];
      init.defaultBranch = "main";
    };

    ignores = [
      "compile_commands.json"
      ".gdbinit"
      "Sesssion.vim"
      ".session.vim"
      ".gitlab.nvim"
    ];
  };

  programs.git-credential-oauth = {
    enable = true;
    # extraFlags = ["-device"];
  };

  home.shellAliases = {
    gl = "glab";
    g = "git";
    ga = "git add";
    gc = "git commit";
  };

  home.packages = [pkgs.git-crypt pkgs.unstable.glab pkgs.unstable.gh];
}
