{...}: {
  home.username = "pguillaume";
  home.homeDirectory = "/data/exports/users/pguillaume/";

  accounts.email.accounts = {
    Sequans = {
      realName = "Pierrick Guillaume";
      address = "pguillaume@sequans.com";
      flavor = "outlook.office365.com";
      primary = true;
    };
  };

  # programs.bash.initExtra = ''
  #   if [[ $(hostname) = 'snorlax' ]]; then
  #     exec fish
  #   fi
  # '';
}
