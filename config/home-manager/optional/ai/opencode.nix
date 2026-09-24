{
  pkgs,
  # config,
  # inputs,
  ...
}: {
  # imports = [ inputs.meridian.homeModules.default ];
  # home.packages = [ config.services.meridian.package ];
  stylix.targets.opencode.enable = true;
  programs.opencode = {
    package = pkgs.unstable.opencode;
    enable = true;
    # settings = {
    #   plugin = ["${pkgs.meridian}/lib/meridian/plugin/meridian.ts"];
    # };
  };
  #
  # services.meridian = {
  #   enable = true;
  #   settings = {
  #     port = 3456;
  #     host = "127.0.0.1";
  #     passthrough = true;
  #     defaultAgent = "opencode";
  #     # sonnetModel = "sonnet";
  #     # Load plugins from the Nix store (rendered to a plugins.json manifest).
  #     # The official scrub plugins ship prebuilt via the meridian overlay:
  #     # pluginConfig = [ { path = pkgs.meridianPlugins.opencode-scrub.path; } ];
  #     # pluginDir = "/path/to/extra/plugins";
  #   };
  #   # Extra env vars not covered by settings
  #   # environment = {
  #   #   MERIDIAN_MAX_CONCURRENT = "20";
  #   # };
  # };
}
