{
  config,
  lib,
  ...
}: {
  preferences.terminal = {
    command = "${lib.getBin config.programs.zellij.package}/bin/zellij";
  };
}
