{...}: {
  home.username = "fymyte";
  home.homeDirectory = "/home/fymyte";

  accounts.email.accounts = {
    Gmail = {
      realName = "Pierrick Guillaume";
      address = "pguillaume@fymyte.com";
      flavor = "gmail.com";
      primary = true;
    };

    pierguill = {
      realName = "Pierrick Guillaume";
      address = "pierguill@gmail.com";
    };
  };

  programs.command-not-found.enable = true;
}
