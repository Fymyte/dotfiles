{
  config,
  pkgs,
  ...
}: let
  screenshot = with pkgs;
    writeShellScriptBin "screenshot" ''
      ${grim}/bin/grim -g "$("${slurp}"/bin/slurp -o)" -t ppm - |
          ${satty}/bin/satty --filename - --fullscreen --initial-tool crop \
            --output-filename ${config.home.homeDirectory}/Pictures/Screenshots/screenshot-$(${pkgs.coreutils}/bin/date '+%Y%m%d-%H:%M:%S').png
    '';
in {
  home.packages = [
    pkgs.grim
    pkgs.slurp
    pkgs.satty
    # (config.lib.nixGL.wrap pkgs.satty)

    screenshot
  ];
}
