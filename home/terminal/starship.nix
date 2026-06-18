{ config, lib, ... }:
with lib;
let
  cfg = config.terminal.starship;
in
{
  options.terminal.starship = {
    enable = mkEnableOption "Enable default Starship configuration";
  };

  config = mkIf cfg.enable {
    stylix.targets.starship.enable = true;

    programs.starship = {
      enable = true;
      settings = {
        format = ''
          [󱞡](bold base0B) [](base02)[$shell$username($nix_shell)](bg:base02)[](base02)[---->](bold base02) $git_branch$git_status$git_state(''\n| $gradle $java $kotlin)(''\n| $rust)(''\n| $c)(''\n| $haskell)(''\n| $deno)
          [󱞩](bold base0B) $directory[->](base08) 
        '';
        right_format = ''
          [](base03)[(󱑀 $cmd_duration)](fg:bold base09 bg:base03)$status
        '';
        shell = {
          disabled = false;
          bash_indicator = "#:";
          zsh_indicator = "Z:";
          nu_indicator = ">:";
          format = "[$indicator]($style)";
          style = "fg:white bg:base02";
        };
        cmd_duration = {
          show_notifications = true;
          style = "fg:base09 bg:base03";
        };
        status = {
          disabled = false;
          format = "[$symbol $status]($style)";
          style = "fg:bold base09 bg:base03";
          success_symbol = " ";
        };
        username = {
          show_always = true;
          format = "[$user]($style)";
          style_user = "fg:magenta bg:base02";
        };
        nix_shell = {
          format = "[( 󱄅 ($name))]($style) ";
          style = "fg:cyan bg:base02";
          heuristic = true;
        };
        git_branch = {
          format = "[$symbol$branch(:$remote_branch)]($style) ";
          style = "bold yellow";
        };
        git_state = {
          rebase = "󰳖 ";
          merge = "󰃸 ";
          revert = " ";
          cherry_pick = " ";
          bisect = " ";
          am = "󰶉 ";
          am_or_rebase = " ";
          style = "italic yellow";
        };
        gradle = {
          format = "[<](blue) [ ($version)](italic blue)[>] (blue)";
          version_format = "\${raw}";
        };
        java = {
          format = "[{](orange) [ ($version)](italic orange) [}](orange)";
        };
        rust = {
          format = "[](red)[ ($version)](fg:bold black bg:red)[](red)";
        };
        c = {
          detect_extensions = [
            "c"
            "h"
            "cpp"
            "hpp"
          ];
          detect_files = [
            ".clang-format"
          ];
          format = "[/* ](bold cyan) [$version](italic green) [ */](bold blue)";
        };
        haskell = {
          format = "[](magenta)[ ($version)]($bold magenta)[](magenta)";
        };
        deno = {
          format = "[ ](blue)[$symbol($version)]($style)[ ](blue)";
          style = "fg:yellow";
          symbol = "󰛦 ";
        };
      };
    };
  };
}
