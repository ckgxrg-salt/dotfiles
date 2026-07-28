{ pkgs, ... }:
{
  device = {
    hostname = "Daywatch";
    laptop = true;
    hostCPU = "intel";
    hostGPU = "intel";
    version = "25.11";
  };
  boot = {
    default = true;
    limine.enable = true;
    kernelPackages = pkgs.linuxPackages_zen;
    bbr = true;
    noCoredump = true;
    splash = "loader_2";
  };
  hardware = {
    default = true;
    btrfs = true;
    wifi = true;
    bt = true;
  };
  login = {
    users.default = true;
    greetd.enable = true;
    howdy.enable = true;
    u2f.enable = true;
  };
  misc = {
    default = true;
    locale.default = true;
    security.default = true;
  };
  virtualisation.waydroid.enable = true;
  program = {
    mihomo.enable = true;
    gamemode.enable = true;
    nix.enable = true;
    steam.enable = true;
    netbird.enable = true;
    speechd.enable = true;
    tuned.enable = true;
    thermald.enable = true;
  };
  theme = {
    cursor = {
      name = "KrisCursor";
      size = 32;
    };
    fonts.sizes = {
      applications = 24;
      desktop = 24;
      popups = 20;
      terminal = 20;
    };
    icons = {
      package = pkgs.vimix-icon-theme;
      name = "Vimix-black-dark";
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
      monospace = [
        "Fira Code"
      ];
      emoji = [
        "Twitter Color Emoji"
      ];
    };
  };

  imports = [
    ./overrides/boot.nix
    ./overrides/disko.nix
    ./overrides/touchscreen.nix
  ];
}
