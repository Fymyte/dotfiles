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
    ];

    extraConfig.credential.helper = ["cache --timeout 21600"];
  };

  programs.git-credential-oauth = {
    enable = true;
  };

  home.packages = [pkgs.unstable.glab];
}
