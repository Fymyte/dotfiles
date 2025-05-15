{lib, ...}:
with lib; {
  options = {
    preferences.terminal = mkOption {
      type = types.submodule {
        options = {
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
