{...}: {
  xdg.configFile."zellij/zellij-autolock.wasm".source = ./zellij-autolock.wasm;
  xdg.configFile."zellij/zellij-sessionizer.wasm".source = ./zellij-sessionizer.wasm;
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;

  programs.zellij.enable = true;
  programs.zellij = {
    # enableFishIntegration = true;
  };
}
