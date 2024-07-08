{ ... }:
{
  # The last word in shells
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      fortune | cowsay | lolcat
    '';

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
    enableVteIntegration = true;
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
        [󱞡](bold green)$shell$nix_shell$username[ ----- ](bold blue)$git_branch$git_status
        [󱞩 ](bold green)$directory[ -> ](blue)
      '';
      shell = {
        disabled = false;
        bash_indicator = "󱆃: ";
        zsh_indicator = ": ";
      };
      username = {
        show_always = true;
      };
    };
  };

  # thefuck Terminal Correction
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}
