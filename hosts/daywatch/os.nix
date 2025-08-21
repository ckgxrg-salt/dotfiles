{
  pkgs,
  ckgs,
  lib,
  ...
}:
# Daywatch OS entrypoint
{
  networking.hostName = "Daywatch";
  system.stateVersion = "24.05";
  boot = {
    default = true;
    kernelPackages = pkgs.linuxPackages_zen;
    bbr = true;
    laptop = true;
    noCoredump = true;
    plymouth = {
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = lib.mkForce "hexa_retro";
    };
  };
  hardware = {
    default = true;
    secureBoot = true;
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
      issue = "====> Daywatch <====";
    };
  };
  misc = {
    default = true;
    locale = {
      default = true;
      timezone = "Asia/Taipei";
    };
    security.default = true;
  };
  program = {
    gamemode.enable = true;
    nix = true;
    steam = true;
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    polarity = "dark";
    cursor = {
      package = ckgs.googledot-cursor;
      name = "GoogleDot-Black";
      size = 24;
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
    ./overrides/fstab.nix
    ./overrides/greetd.nix
  ];
}
