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
  system.stateVersion = "25.11";
  boot = {
    default = true;
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
    zfs = true;
    microsoft-surface.kernelVersion = "stable";
  };
  services.sanoid.datasets = {
    "asedia/home".useTemplate = [ "default" ];
  };
  login = {
    greetd = {
      enable = true;
      autoLogin = true;
      greetMessage = "====> Asedia <====";
    };
    users = {
      default = true;
      issue = "====> Asedia <====\n";
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
  #virtualisation.waydroid.enable = true;
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
