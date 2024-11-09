{ config, ... }:
{
  # Terminal Prompt for Aliens
  programs.starship = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    settings = {
      format = ''
        [󱞡 ](bold green)[](#4F585E)[$shell$username($nix_shell)](bg:#3F5865)[](#3F5865)[----> ](bold blue)$git_branch$git_status$git_state(''\n| $gradle $java)(''\n| $rust)
        [󱞩 ](bold green)$directory[-> ](blue)
      '';
      right_format = ''
        [](#55544A)[(󱑀 $cmd_duration)](fg:bold yellow bg:#59464C)$status
      '';
      shell = {
        disabled = false;
        bash_indicator = "󱆃 :";
        zsh_indicator = "Z:";
        nu_indicator = ">:";
        format = "[$indicator]($style)";
        style = "fg:#D3C6AA bg:#4F585E";
      };
      cmd_duration = {
        show_notifications = true;
        style = "fg:#DBBC7F bg:#59464C";
      };
      status = {
        disabled = false;
        format = "[$symbol $status]($style)";
        style = "fg:bold yellow bg:#59464C";
        success_symbol = " ";
      };
      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "fg:#D699B6 bg:#3C4841";
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        style = "green";
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
        format = "[](#384B55)[$symbol($version)]($style)[](#384B55)";
        version_format = "\${raw}";
        style = "fg:italic bright-blue bg:#384B55";
        symbol = " ";
      };
      java = {
        format = "[](#514045)[$symbol($version)]($style)[](#514045)";
        style = "fg:#E69875 bg:#514045";
        symbol = " ";
      };
      rust = {
        format = "[](#493B40)[$symbol($version)]($style)[](#493B40)";
        style = "fg:bold red bg:#493B40";
        symbol = " ";
      };
      nix_shell = {
        format = "[( $symbol($name))]($style) ";
        symbol = "󱄅 ";
        style = "fg:italic bright-blue bg:#3F5865";
        heuristic = true;
      };
    };
  };
}
