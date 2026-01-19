# Rhyslow OS entrypoint
{
  pkgs,
  lib,
  ...
}:
{
  device = {
    hostname = "Rhyslow";
    hostCPU = "amd";
    hostGPU = "nvidia";
    version = "25.11";
  };
  boot = {
    default = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    bbr = true;
    noCoredump = true;
    plymouth = {
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = lib.mkForce "connect";
    };
  };
  hardware = {
    default = true;
    btrfs = true;
    bt = true;
    nvidia = {
      prime = {
        nvidiaBusId = "PCI:1@0:0:0";
        amdgpuBusId = "PCI:12@0:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
  login = {
    greetd = {
      enable = true;
      autoLogin = true;
    };
    users.default = true;
  };
  misc = {
    default = true;
    locale = {
      default = true;
      timezone = "Europe/London";
    };
    security.default = true;
  };
  program = {
    gamemode.enable = true;
    nix.enable = true;
    openrgb = {
      enable = true;
      loadDefault = true;
    };
    steam.enable = true;
    tailscale.enable = true;
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tomorrow-night.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.lyra-cursors;
      name = "LyraB-cursors";
      size = 16;
    };
    fonts.sizes = {
      applications = 16;
      desktop = 16;
      popups = 14;
      terminal = 14;
    };
  };
  fonts = {
    packages = with pkgs; [
      jost
      noto-fonts-cjk-sans
      maple-mono.NF
      noto-fonts-color-emoji
      # Fallback fonts
      fira-math
      noto-fonts
      liberation_ttf
    ];
    fontconfig.defaultFonts = {
      sansSerif = [
        "Jost*"
        "Noto Sans CJK SC"
      ];
      serif = [
        "Liberation Serif"
        "Noto Sans CJK SC"
      ];
      monospace = [ "Maple Mono NF" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  imports = [
    ./overrides/boot.nix
    ./overrides/disko.nix
    ./overrides/mark-gpu.nix
  ];
}
