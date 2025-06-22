{
  config,
  pkgs,
  ckgs,
  lib,
  ...
}:
# Daywatch OS entrypoint
{
  networking.hostName = "Daywatch";
  system.stateVersion = "24.05";
  boot = {
    default = true;
    kernelPackages = pkgs.linuxPackages_zen;
    bbr = true;
    laptop = true;
    noCoredump = true;
    plymouth = {
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = lib.mkForce "hexa_retro";
    };
  };
  hardware = {
    default = true;
    secureBoot = true;
    laptop = true;
    wifi = true;
    bt = true;
    hostCPU = "intel";
    hostGPU = "intel";
  };
  login = {
    greetd = {
      enable = true;
      autoLogin = true;
      greetMessage = "====> Daywatch <====";
    };
    users = {
      default = true;
      issue = "====> Daywatch <====";
    };
  };
  misc = {
    default = true;
    locale = {
      default = true;
      timezone = "Asia/Taipei";
    };
    security.default = true;
  };
  apps = {
    gamemode.enable = true;
    nix = true;
    steam = true;
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    polarity = "dark";
    cursor = {
      package = ckgs.googledot-cursor;
      name = "GoogleDot-Black";
      size = 24;
    };
    fonts = {
      sizes = {
        applications = 18;
        desktop = 18;
        popups = 12;
        terminal = 18;
      };
      sansSerif = {
        package = pkgs.jost;
        name = "Jost*";
      };
      serif = config.stylix.fonts.sansSerif;
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
  theme.sound.enable = true;

  imports = [
    ./overrides/boot.nix
    ./overrides/fonts.nix
    ./overrides/fstab.nix
    ./overrides/greetd.nix
  ];
}
