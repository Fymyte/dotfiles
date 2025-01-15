{...}: {
  home.username = "fymyte";
  home.homeDirectory = "/home/fymyte";

  accounts.email.accounts = {
    Fymyte = {
      realName = "Pierrick Guillaume";
      address = "pguillaume@fymyte.com";
    };

    pierguill = {
      realName = "Pierrick Guillaume";
      address = "pierguill@gmail.com";
      flavor = "gmail.com";
      primary = true;
    };
  };
}
