{
  config,
  inputs,
  pkgs,
  ...
}: {
  sops.templates."nix-access-tokens.conf".content = ''
    extra-access-tokens = github.com=${config.sops.placeholder.github-token}
  '';

  nix = {
    package = pkgs.nix;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings.experimental-features = ["nix-command" "flakes"];

    extraOptions = ''
      !include ${config.sops.templates."nix-access-tokens.conf".path}
    '';
    # settings.access-tokens = ["github.com=${secrets.github-token}"];
  };
}
