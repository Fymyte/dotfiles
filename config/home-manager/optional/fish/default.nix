{
  config,
  pkgs,
  lib,
  ...
}: let
  brackets-color = "9399B2";

  not-abbreviated = [
    "page"
    "less"
  ];
in {
  stylix.targets.fish.enable = false;
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    # Replace global aliases by fish abbreviation
    shellAbbrs = lib.attrsets.filterAttrs (n: v: lib.lists.all (x: x != n) not-abbreviated) config.home.shellAliases;

    plugins = [
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "79b62958ecf4e87334f24d6743e5766475bcf4d0";
          sha256 = "3d/qL+hovNA4VMWZ0n1L+dSM1lcz7P5CQJyy+/8exTc=";
        };
      }
      {
        name = "catppuccin";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "fish";
          rev = "6a85af2ff722ad0f9fbc8424ea0a5c454661dfed";
          sha256 = "sha256-Oc0emnIUI4LV7QJLs4B2/FQtCFewRFVp7EDv8GawFsA=";
        };
      }
    ];

    functions = {
      fish_prompt.body = ''
        set -l normal_color     (set_color normal)
        set -l arrow_color

        echo -n -s (set_color blue) (prompt_pwd) $normal_color

        switch $fish_bind_mode
          case insert
            set arrow_color 8787FF
          case replace_one
            set arrow_color --bold green
          case visual
            set arrow_color --bold brmagenta
          case '*'
            set arrow_color --bold red
        end

        echo -n -s (set_color $arrow_color) " » " $normal_color
      '';
      # No mode prompt, as it is integrated with the left prompt
      fish_mode_prompt.body = "";
      fish_right_prompt.body = ''
        set -l last_status $status

        if [ $last_status -ne 0 ]
          echo -n -s (set_color red) $last_status " ↵ " (set_color normal)
        end

        begin
          set -lx __fish_git_prompt_showdirtystate 1
          set -lx __fish_git_prompt_showcolorhints 1
          set -lx __fish_git_prompt_color_prefix "${brackets-color}"
          set -lx __fish_git_prompt_color_suffix "${brackets-color}"

          fish_git_prompt
        end
      '';
    };

    shellInit = builtins.readFile ./default.fish;
    interactiveShellInit = builtins.readFile ./interactive.fish;
  };
}
