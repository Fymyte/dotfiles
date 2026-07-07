{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.programs.niri;
in
  with lib; {
    options.programs.niri = {
      enable = mkEnableOption "Enable niri config";
      # package = mkPackageOption pkgs "niri" { };

      monitors = mkOption {
        type = types.listOf types.str;
        description = "List of monitor configuration";
      };

      config = mkOption {
        type = types.str;
        description = "niri configuration";
      };
    };

    config = lib.mkIf cfg.enable {
      xdg.configFile."niri/config.kdl".text =
        cfg.config
        + "\n"
        + lib.concatStrings (map (mon: mon + "\n") cfg.monitors);
    };
  }
