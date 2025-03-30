{lib, ...}:
with lib; {
  options = {
    preferences.terminal = mkOption {
      type = types.submodule {
        options = {
          font-size = mkOption {
            type = types.int;
            example = 12;
            description = "Font size to use.";
          };

          command = mkOption {
            type = types.str;
            example = "bash";
            description = "Application to start when openning a terminal";
          };
        };
      };
    };
  };
}
