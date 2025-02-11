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

    ignores = [
      "compile_commands.json"
      ".gdbinit"
      ".session.nvim"
    ];

    extraConfig.credential.helper = ["cache --timeout 21600"];
  };

  programs.git-credential-oauth = {
    enable = true;
  };

  # programs.gh = {
  #   enable = true;
  #   gitCredentialHelper.enable = true;
  #   settings = {
  #     git_protocol = "https";
  #     prompt = "enabled";

  #     aliases = {
  #       co = "pr checkout";
  #       pv = "pr view";
  #     };
  #   };
  # };
}
