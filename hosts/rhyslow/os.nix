{
  config,
  pkgs,
  lib,
  ...
}:
# Rhyslow OS entrypoint
{
  networking.hostName = "Rhyslow";
  networking.hostId = "aa2caad5";
  system.stateVersion = "25.05";
  boot = {
    default = true;
    kernelVariant = pkgs.linuxPackages_xanmod_latest;
    bbr = true;
    noCoredump = true;
    plymouth = {
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = lib.mkForce "connect";
    };
  };
  hardware = {
    default = true;
    hostCPU = "intel";
    hostGPU = "nvidia";
    bt = true;
  };
  login = {
    greetd = {
      enable = true;
      autoLogin = true;
      greetMessage = ''====> Rhyslow <===='';
    };
    users = {
      default = true;
      issue = ''====> Rhyslow <===='';
    };
  };
  misc = {
    default = true;
    locale = {
      default = true;
      timezone = "Asia/Singapore";
    };
    security.default = true;
  };
  apps = {
    gamemode.enable = true;
    nix = true;
    openrgb = {
      enable = true;
      loadDefault = true;
    };
    steam = true;
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atlas.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.lyra-cursors;
      name = "LyraB-cursors";
      size = 48;
    };
    fonts = {
      sizes = {
        applications = 24;
        desktop = 24;
        popups = 20;
        terminal = 22;
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
