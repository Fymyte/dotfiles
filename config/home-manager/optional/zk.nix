{
  pkgs,
  config,
  ...
}: {
  programs.zk = {
    enable = true;
    package = pkgs.unstable.zk;

    settings = {
      notebook.dir = "~/notes";
    };
  };

  home.sessionVariables = {
    ZK_NOTEBOOK_DIR = config.programs.zk.settings.notebook.dir;
  };
}
