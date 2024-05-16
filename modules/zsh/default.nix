{ pkgs, lib, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      fortune | cowsay | lolcat
    '';

    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
    };

    shellAliases = {
      tip = "fortune | cowsay | lolcat";
      setproxy = "export all_proxy=socks5://127.0.0.1:20170";
      unproxy = "unset all_proxy";
      gitproxy = "git config --global http.proxy socks5://127.0.0.1:20170 && git config --global https.proxy socks5://127.0.0.1:20170";
      gitunproxy = "git config --global --unset http.proxy && git config --global --unset https.proxy";
      flake-update = "pushd /etc/nixos && sudo nix flake update && popd";
      deploy = "sudo nixos-rebuild switch --flake /home/ckgxrg/dotfiles";
      clear = "clear && tip";
    };
  };

  # thefuck Terminal Correction
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}
