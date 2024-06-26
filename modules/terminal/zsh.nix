{ ... }:
# The last word in shells
{
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      eval $(thefuck --alias)
      any-nix-shell zsh --info-right | source /dev/stdin
      fortune | cowsay | lolcat
    '';

    oh-my-zsh = {
      enable = true;
      theme = "muse";
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
      "clear" = "clear && ciallo";
    };
  };

  # thefuck Terminal Correction
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}
