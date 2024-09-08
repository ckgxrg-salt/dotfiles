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
}