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
      "deploy" = "nh os switch --ask";
      "purge" = "nh clean all --ask";
      "clear" = "clear && ciallo";
    };
  };
}
