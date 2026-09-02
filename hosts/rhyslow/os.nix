{ pkgs, ... }:
{
  device = {
    hostname = "Rhyslow";
    hostCPU = "amd";
    hostGPU = "nvidia";
    bt = true;
    version = "25.11";
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    splash = "spin";
  };
  hardware = {
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
    u2f.enable = true;
  };
  program = {
    gamemode.enable = true;
    netbird.enable = true;
    nix.enable = true;
    mihomo.enable = true;
    openrgb = {
      enable = true;
      loadDefault = true;
    };
    steam.enable = true;
    sunshine.enable = true;
    wivrn.enable = true;
  };
  theme = {
    cursor = {
      name = "KrisCursor";
      size = 32;
    };
    fonts.sizes = {
      applications = 16;
      desktop = 24;
      popups = 14;
      terminal = 14;
    };
    icons = {
      package = pkgs.dracula-icon-theme;
      name = "Dracula";
    };
  };
  fonts = {
    packages = with pkgs; [
      fira-code
      quicksand
      lxgw-wenkai

      # Symbols
      twitter-color-emoji
      fira-math
      nerd-fonts.iosevka

      # Fallback fonts
      noto-fonts
      noto-fonts-cjk-sans
    ];
    fontconfig.defaultFonts = {
      sansSerif = [
        "Quicksand"
        "LXGW WenKai"
      ];
      serif = [
        "Quicksand"
        "LXGW WenKai"
      ];
      monospace = [ "Fira Code" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };

  imports = [
    ./overrides/boot.nix
    ./overrides/fstab.nix
    ./overrides/hardware.nix
    ./overrides/mark-gpu.nix
  ];
}
