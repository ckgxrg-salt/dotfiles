{
  pkgs,
  lib,
  ...
}:
# Daywatch OS entrypoint
{
  networking.hostName = "Daywatch";
  networking.hostId = "2e6fdeab";
  system.stateVersion = "25.11";
  boot = {
    default = true;
    kernelPackages = pkgs.linuxPackages_zen;
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
    btrfs = true;
    secureBoot = false;
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
      issue = "====> Daywatch <====\n";
    };
  };
  misc = {
    default = true;
    locale = {
      default = true;
      autoTimezone = true;
    };
    security = {
      default = true;
      waydroid = true;
    };
  };
  virtualisation.waydroid.enable = true;
  program = {
    gamemode.enable = true;
    nix = true;
    steam = true;
    tailscale = true;
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nebula.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.graphite-cursors;
      name = "graphite-dark";
      size = 28;
    };
    fonts.sizes = {
      applications = 24;
      desktop = 24;
      popups = 20;
      terminal = 20;
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
  theme.sound.enable = true;

  imports = [
    ./overrides/boot.nix
    ./overrides/disko.nix
    ./overrides/touchscreen.nix
  ];
}
