{
  config,
  pkgs,
  lib,
  ...
}:
# Asedia OS entrypoint
{
  networking.hostName = "Asedia";
  networking.hostId = "2e6fdeab";
  system.stateVersion = "25.05";
  boot = {
    default = true;
    kernelVariant = pkgs.linuxPackages_zen;
    bbr = true;
    laptop = true;
    noCoredump = true;
    plymouth = {
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = lib.mkForce "loader_2";
    };
  };
  hardware = {
    default = true;
    secureBoot = false;
    laptop = true;
    wifi = true;
    bt = true;
    hostCPU = "intel";
    hostGPU = "intel";
  };
  services.zfs = {
    trim.enable = true;
    autoScrub.enable = true;
    autoSnapshot = {
      enable = true;
      weekly = 4;
      monthly = 2;
      hourly = 0;
      frequent = 0;
      daily = 7;
    };
  };
  login = {
    greetd = {
      enable = true;
      autoLogin = true;
      greetMessage = ''====> Asedia <===='';
    };
    users = {
      default = true;
      issue = ''====> Asedia <===='';
    };
  };
  misc = {
    default = true;
    locale = {
      default = true;
      timezone = "Asia/Macao";
    };
    security = {
      default = true;
      waydroid = true;
    };
  };
  virtualisation.waydroid.enable = true;
  apps = {
    gamemode.enable = true;
    nix = true;
    steam = true;
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.graphite-cursors;
      name = "graphite-dark";
      size = 28;
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
    ./overrides/disko.nix
    ./overrides/fonts.nix
  ];
}
