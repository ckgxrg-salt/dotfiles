{ pkgs, ckgs, ... }:
# These options are almost identical on each system
{
  #========== Boot ==========#
  boot = {
    # Setup Secure Boot
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    bootspec.enable = true;

    # Not using containers here
    enableContainers = false;
    tmp.cleanOnBoot = true;
  };

  #========== Appearance ==========#
  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts-emoji
      maple-mono-SC-NF
      ckgs.maple-ui
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Maple Mono SC NF"
        ];
        sansSerif = [
          "Maple UI"
        ];
        serif = [
          "Maple UI"
        ];
      };
    };
  };

  #========== Localisation ==========#
  # Timezone, Locale
  time.timeZone = "Asia/Shanghai";
  services.timesyncd.enable = false;
  services.openntpd.enable = true;

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "zh_CN.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  #========== Users ==========#
  # Replace the default perl script
  services.userborn.enable = true;

  #========== Miscellaneous ==========#
  programs.dconf.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  virtualisation.waydroid.enable = true;
  system.etc.overlay.enable = true;
  programs.nix-ld.enable = true;

  systemd = {
    oomd.enable = false;
    coredump.enable = false;
  };

  # Placeholders
  programs.nano.enable = false;
  programs.command-not-found.enable = false;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    systemd.setPath.enable = true;
  };

  # XDG Portal Placeholder
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  # Who'll need this...
  documentation = {
    nixos.enable = false;
    info.enable = false;
  };
  environment.defaultPackages = [ ];
  services.speechd.enable = false;
  system.tools.nixos-option.enable = false;
}
