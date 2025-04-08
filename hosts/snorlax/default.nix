{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops.homeManagerModules.sops
  ];

  # This is not a nixos system
  nixGL.packages = inputs.nixgl.packages;

  home.sessionPath = [
    "/opt/soft/toolchains64/nds32le-unknown-elf/bin"
  ];

  home.sessionVariables = {
    GL_HOST = "gitlab-shared.sequans.com";
  };

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSymlinkPath = "/run/user/2246/sops-nix/secrets";
    defaultSecretsMountPoint = "/run/user/2246/sops-nix/secrets.d";
  };
}
