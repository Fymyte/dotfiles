{config, ...}: let
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

    ignores = ["compile_commands.json"];
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";

      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };
}
