{
  config,
  lib,
  ...
}: {
  options.hostSpec = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the primary user on the host";
    };

    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };

    emails = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "The Email list of the user";
    };

    domain = lib.mkOption {
      type = lib.types.str;
      description = "The search domain of the host";
    };

    wifi = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the host has WiFi";
    };

    userFullName = lib.mkOption {
      type = lib.types.str;
      description = "The full name of the user";
    };

    handle = lib.mkOption {
      type = lib.types.str;
      default = config.hostSpec.username;
      description = "The handle of the user (eg: GitHub username)";
    };

    home = lib.mkOption {
      type = lib.types.str;
      default = let
        username = config.hostSpec.username;
      in "/home/${username}";
      description = "The home directory of the primary user";
    };

    isServer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Indicates whether host is a server";
    };

    isNixOS = lib.mkOption {
      type = lib.types.bool;
      description = "Indicates whether host is running NixOS";
    };

    headless = lib.mkOption {
      type = lib.types.bool;
      description = "Indicates whether host is running headless (no graphical session)";
      default = false;
    };
  };

  config = {};
}
