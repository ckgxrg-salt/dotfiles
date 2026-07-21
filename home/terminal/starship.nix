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
    # TODO: matugen for starship

    programs.starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "[󱞡](bold green) "
          "[](base02)[$shell$username($nix_shell)](bg:base02)[](base02)"
          "$fill"
          "([](base02)$cmd_duration[](base02))"
          "(\n| $gradle $java)(\n| $rust)(\n| $c)(\n| $haskell)"
          "$line_break"
          "[󱞩](bold green) $directory$shlvl$character"
        ];
        right_format = "([](base02)$git_branch$git_status$git_state[](base02))";

        shell = {
          disabled = false;
          bash_indicator = "#:";
          nu_indicator = ">:";
          format = "[$indicator]($style)";
          style = "fg:bright-white bg:base02";
        };
        username = {
          show_always = true;
          format = "[$user]($style)";
          style_user = "fg:magenta bg:base02";
        };
        nix_shell = {
          format = "[( 󱄅 ($name))]($style) ";
          style = "fg:#5FB8F2 bg:base02";
          heuristic = true;
        };
        fill = {
          symbol = "=";
          style = "bold base02";
        };
        shlvl = {
          disabled = false;
          repeat = true;
          repeat_offset = 1;
          symbol = "";
          format = "[$symbol](bright-black)";
        };
        character = {
          success_symbol = "[](bold green)";
          error_symbol = "[](bold red)";
        };
        cmd_duration = {
          format = "[ $duration](fg:orange bg:base02)";
        };

        git_branch = {
          format = "[$symbol$branch(:$remote_branch) ]($style)";
          style = "fg:bold yellow bg:base02";
        };
        git_state = {
          rebase = "󰳖 ";
          merge = "󰃸 ";
          revert = " ";
          cherry_pick = " ";
          bisect = " ";
          am = "󰶉 ";
          am_or_rebase = " ";
          style = "fg:italic magenta bg:base02";
        };
        git_status = {
          format = "([\\[$all_status$ahead_behind\\]]($style))";
          style = "fg:bold orange bg:base02";
        };

        gradle = {
          format = "[<](#4DC9C0) [ ($version)](italic #209BC4) [>](#4DC9C0)";
          version_format = "\${raw}";
        };
        java = {
          format = "[{](#C74634) [ ($version)](italic #C2D4D4) [}](#C74634)";
        };
        rust = {
          format = "[](#D34516)[ ($version)](fg:bold #1E2650 bg:#D34516)[](#D34516)";
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
          format = "[/* ](bold #004482) [$version](italic #659AD2) [ */](bold #00599C)";
        };
        haskell = {
          format = "[](#453A62)[ ($version)]($bold #8F4E8B)[](#5E5086)";
        };
      };
    };
  };
}
