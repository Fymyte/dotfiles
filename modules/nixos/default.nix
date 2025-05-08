{lib, ...}: {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common"
    ])
  ];
}
