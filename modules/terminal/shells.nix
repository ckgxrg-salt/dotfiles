{ ... }:
{
  # The last word in shells
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
    };

    initExtra = ''
      fortune | cowsay | lolcat
    '';
    sessionVariables = {
      MANPAGER = "nvim +Man!";
    };
    shellAliases = {
      "ciallo" = "fortune | cowsay | lolcat";
      "setproxy" = "export all_proxy=socks5://127.0.0.1:20170";
      "unproxy" = "unset all_proxy";
      "gitproxy" =
        "git config --global http.proxy socks5://127.0.0.1:20170 && git config --global https.proxy socks5://127.0.0.1:20170";
      "gitunproxy" =
        "git config --global --unset http.proxy && git config --global --unset https.proxy";
      "deploy" = "nh os switch --ask";
      "purge" = "nh clean all --ask";
      "clear" = "clear && ciallo";
    };
  };

  # Let home-manager to manage the GNU Bourne-Again Shell
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      "ciallo" = "fortune | cowsay | lolcat";
      "setproxy" = "export all_proxy=socks5://127.0.0.1:20170";
      "unproxy" = "unset all_proxy";
      "gitproxy" =
        "git config --global http.proxy socks5://127.0.0.1:20170 && git config --global https.proxy socks5://127.0.0.1:20170";
      "gitunproxy" =
        "git config --global --unset http.proxy && git config --global --unset https.proxy";
      "deploy" = "nh os switch --ask";
      "purge" = "nh clean all --ask";
      "clear" = "clear && ciallo";
    };
  };

  # Starship Terminal Prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = false;
    enableZshIntegration = true;
    settings = {
      format = ''
        [󱞡 ](bold green)$shell$username($nix_shell)[----> ](bold blue)$git_branch$git_status(''\n| $gradle$java)
        [󱞩 ](bold green)$directory[-> ](blue)
      '';
      right_format = ''
        [󱑀 $cmd_duration](bold green)[󰮳 : $status](bold blue)
      '';
      shell = {
        disabled = false;
        bash_indicator = "󱆃 :";
        zsh_indicator = " :";
      };
      status = {
        disabled = false;
        success_symbol = " ";
      };
      username = {
        show_always = true;
      };
      gradle = {
        format = "[$symbol($version Project )]($style)";
        version_format = "\${raw}";
        style = "italic yellow";
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

  # thefuck Terminal Correction
  programs.thefuck = {
    #enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
