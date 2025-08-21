{
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
    secureBoot = false;
    laptop = true;
    wifi = true;
    bt = true;
    hostCPU = "intel";
    hostGPU = "intel";
    zfs = true;
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
      timezone = "Asia/Shanghai";
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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
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
      terminal = 22;
    };
  };
  fonts = {
    packages = with pkgs; [
      jost
      noto-fonts-cjk-sans
      maple-mono.NF
      noto-fonts-emoji
    ];
    fontconfig.defaultFonts = {
      sansSerif = [
        "Jost*"
        "Noto Sans CJK SC"
      ];
      serif = [
        "Jost*"
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
