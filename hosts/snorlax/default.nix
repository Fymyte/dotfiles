{
  config,
  inputs,
  ...
}: {
  sops.defaultSopsFile = ../../secrets/sequans.yaml;

  # home.username = "pguillaume";
  # home.homeDirectory = "/data/exports/users/${config.home.username}";

  # programs.git.userEmail = "${config.home.username}@sequans.com";

  # This is not a nixos system
  nixGL.packages = inputs.nixgl.packages;

  home.sessionPath = [
    "/opt/soft/toolchains64/nds32le-unknown-elf/bin"
    "${config.home.homeDirectory}/dev/sqn/sqn-sdk/tools/scriptkit/bash/"
    "${config.home.homeDirectory}/x-tools/nds32le-linux/bin/"
  ];

  home.sessionVariables = {
    GL_HOST = "gitlab-shared.sequans.com";
  };
}
