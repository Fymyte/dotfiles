{
  config,
  lib,
  ...
}: {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/home-manager"
    ])

    (lib.custom.scanPaths ./.)
  ];
}
