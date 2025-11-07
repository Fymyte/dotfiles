{
  pkgs,
  config,
  ...
}: let
  templates = "zk/templates";
in {
  programs.zk = {
    enable = true;
    package = pkgs.unstable.zk;

    settings = {
      notebook.dir = config.home.homeDirectory + "notes";
      note = {
        filename = "{{id}}-{{slug title}}";
        templates = config.xdg.configHome + "/${templates}";
      };
      group.sequans = {
        path = "sequans";
      };
      group.journal = {
        path = "journal/**";
        note = {
          filename = "{{format-date now}}";
          template = "journal.md";
        };
      };
      # User defined additional variables (https://zk-org.github.io/zk/config/config-extra.html)
      extra = {
        author = config.hostSpec.userFullName;
      };

      lsp.diagnostics.wiki-link = "hint";
    };
  };

  home.sessionVariables = {
    ZK_NOTEBOOK_DIR = config.programs.zk.settings.notebook.dir;
  };

  xdg.configFile.${templates}.source = ./templates;
}
