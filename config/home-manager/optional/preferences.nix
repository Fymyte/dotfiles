{pkgs, lib, ...}: {
  preferences.terminal = {
    command = "${lib.getBin pkgs.zellij}/bin/zellij";
  };
}
