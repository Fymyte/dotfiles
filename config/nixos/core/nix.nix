{
  config,
  inputs,
  outputs,
  lib,
  ...
}: {
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {allowUnfree = true;};
  };

  sops.templates."nix-access-tokens.conf".content = ''
    extra-access-tokens = github.com=${config.sops.placeholder.github-token}
  '';

  nix = {
    # This will add each flake input as a registry
    # To make nix commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Resonable defaults from https://jackson.dev/post/nix-reasonable-defaults/
      # Connect to ssubstituter fails after 5s instead of never
      connect-timeout = 5;

      # Leave at least 128MB of space: still be able to boot
      min-free = 128000000;
      # Continue auto gc to leave at least 1G of free space
      max-free = 1000000000;

      # Allow building from source if substituter is not available
      fallback = true;

      # Don't complain about dirty git tree
      warn-dirty = false;

      # Auto dedup files with same content
      auto-optimise-store = true;

      # Make all sudo users trusted user
      trusted-users = ["@wheel"];
      experimental-features = ["nix-command" "flakes"];
    };

    extraOptions = ''
      !include ${config.sops.templates."nix-access-tokens.conf".path}
    '';
  };
}
