{
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
}
