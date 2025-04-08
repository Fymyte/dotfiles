{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.page
  ];

  home.sessionVariables = {
    PAGER = "${pkgs.page}/bin/page -WC -q 99999 -z 99999";
    MANPAGER = "${pkgs.page}/bin/page -t man";
  };

  home.shellAliases = {
    page = config.home.sessionVariables.PAGER;
    less = config.home.sessionVariables.PAGER;
  };
}
