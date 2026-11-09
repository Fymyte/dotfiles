{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.sap.homeManagerModules.default];

  # For login-command below
  home.packages = [
    pkgs.bitwarden-cli
    pkgs.jq
  ];

  programs.sap = {
    enable = true;
    settings = {
      url = "https://my036249.sapbydesign.com/sap/public/ap/ui/repository/SAP_UI/HTMLOBERON5/client.html?app.component=/SAP_UI_CT/Main/root.uiccwoc&rootWindow=X&redirectUrl=/sap/public/byd/runtime";
      login-command = ''
        bw get item "SAP Sequans" --session "''${BW_SESSION:-$(bw unlock --raw)}" |
          jq -r '.login.username, .login.password'
      '';

      timesheet = {
        default-task = "switch";
        # Remote work is booked as an absence but is worked time on top of the task hours
        ignore = ["Remote Work"];
        tasks.switch = {
          task = "SWITCH-SW_CORP - SWITCH-SW";
          activity = "Project Service";
        };
      };
    };
  };
}
