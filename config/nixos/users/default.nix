{
  config,
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: let
  hostSpec = config.hostSpec;

  ifGroupsExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.${hostSpec.username} = {
    description = hostSpec.userFullName;
    isNormalUser = true;

    extraGroups = lib.flatten [
      "wheel" # Primary user is always a sudoer

      (ifGroupsExists [
        "audio"
        "video"
        "docker"
        "networkmanager"
      ])
    ];

    packages = lib.flatten [
      (lib.optionalAttrs (!hostSpec.headless) [
        pkgs.wl-clipboard
      ])
    ];

    # TODO: add authorized keys automatically
  };

  home-manager =
    lib.optionalAttrs (
      builtins.pathExists (lib.custom.relativeToRoot
        "home/${hostSpec.username}/${hostSpec.hostName}")
    ) {
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      users.${hostSpec.username}.imports = [(lib.custom.relativeToRoot "home/${hostSpec.username}/${hostSpec.hostName}")];
    };
}
