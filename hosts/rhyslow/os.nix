{
  pkgs,
  lib,
  ...
}:
# Rhyslow OS entrypoint
{
  networking.hostName = "Rhyslow";
  networking.hostId = "aa2caad5";
  system.stateVersion = "25.11";
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
    hostCPU = "amd";
    hostGPU = "nvidia";
    bt = true;
    btrfs = true;
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
  theme.sound.enable = true;

  imports = [
    ./overrides/boot.nix
    ./overrides/disko.nix
  ];
}
