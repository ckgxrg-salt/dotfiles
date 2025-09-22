{
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
    hostCPU = "intel";
    hostGPU = "nvidia";
    bt = true;
    zfs = true;
  };
  services.sanoid.datasets = {
    "rhyslow/home".useTemplate = [ "default" ];
  };
  login = {
    greetd = {
      enable = true;
      autoLogin = true;
      greetMessage = "====> Rhyslow <====";
    };
    users = {
      default = true;
      issue = "====> Rhyslow <====";
    };
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
    nix = true;
    openrgb = {
      enable = true;
      loadDefault = true;
    };
    steam = true;
    tailscale = true;
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
  ];
}
