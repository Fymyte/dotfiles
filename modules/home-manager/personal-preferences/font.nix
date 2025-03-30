{config, lib, ...}:
with lib; let
  fontType = types.submodule {
    options = {
      package = lib.mkOption {
        description = "Package providing the font.";
        type = lib.types.package;
      };

      name = lib.mkOption {
        description = "Name of the font within the package.";
        type = lib.types.str;
      };
    };
  };
in {
  options = {
    preferences.font = mkOption {
      type = types.submodule {
        options = {
          monospace = mkOption {
            type = fontType;
            description = ''
              Monospace font to use.
              This will be the default font for terminal applications as well.
            '';
          };
        };
      };
    };
  };

  config.home.packages = [
    config.preferences.font.monospace.package
  ];
}
