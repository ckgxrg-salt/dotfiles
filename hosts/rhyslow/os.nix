# Rhyslow OS entrypoint
{
  pkgs,
  ckgs,
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
    limine.enable = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    bbr = true;
    noCoredump = true;
    splash = "spin";
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
    greetd.enable = true;
    u2f.enable = true;
    users.default = true;
  };
  misc = {
    default = true;
    locale.default = true;
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
    netbird.enable = true;
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
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
      maple-mono.opentype
      lxgw-neoxihei
      ckgs.offside
      noto-fonts-cjk-sans

      nerd-fonts.iosevka
      twitter-color-emoji
      fira-math
    ];
    fontconfig.defaultFonts = {
      sansSerif = [
        "Offside"
        "LXGW Neo XiHei"
      ];
      serif = [
        "Offside"
        "LXGW Neo XiHei"
      ];
      monospace = [
        "Maple Mono"
      ];
      emoji = [
        "Twitter Color Emoji"
      ];
    };
  };

  imports = [
    ./overrides/boot.nix
    ./overrides/disko.nix
    ./overrides/mark-gpu.nix
  ];
}
