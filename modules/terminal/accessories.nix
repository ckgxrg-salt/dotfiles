{ config, pkgs, ... }:
{
  # thefuck Terminal Correction
  programs.thefuck = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableNushellIntegration = config.programs.nushell.enable;
  };

  # Carapace Argument Completions
  programs.carapace = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableNushellIntegration = config.programs.nushell.enable;
  };

  # Vivid the ls Color Generator
  home.packages = with pkgs; [
    vivid
  ];

  # Terminal Prompt for Aliens
  programs.starship = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    settings = {
      format = ''
        [󱞡 ](bold green)$shell$username($nix_shell)[----> ](bold blue)$git_branch$git_status$git_state(''\n| $gradle$java)
        [󱞩 ](bold green)$directory[-> ](blue)
      '';
      right_format = ''
        [(󱑀 $cmd_duration)](bold green)$status
      '';
      shell = {
        disabled = false;
        bash_indicator = "󱆃 :";
        zsh_indicator = "Z:";
        nu_indicator = ">:";
        format = "[$indicator]($style)";
      };
      status = {
        disabled = false;
        format = 	"[$symbol $status]($style)";
        style = "bold yellow";
        success_symbol = " ";
      };
      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "italic purple";
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
        format = "[$symbol($version Project )]($style)";
        version_format = "\${raw}";
        style = "italic bright-blue";
        symbol = " ";
      };
      java = {
        format = "[$symbol($version )]($style)";
      };
      nix_shell = {
        format = "[($symbol( $name))]($style) ";
        style = "italic bright-blue";
        heuristic = true;
      };
    };
  };
}