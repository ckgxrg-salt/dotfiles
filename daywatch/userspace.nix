{ pkgs, ... }:
# Settings for general userspace
{
  #========== Localisation ==========#
  # Timezone, Locale
  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "zh_CN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
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

  #========== Appearance ==========#
  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts-emoji
      maple-mono-SC-NF
      ckgs.maple-ui
      nerd-fonts.symbols-only
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

  #========== Users ==========#
  # Greet messages
  environment.etc = {
    "motd".text = ''
                 \\
                  \\
      ========     ||
                   ||
      ========     ||
                  //
                 //
    '';
    "issue".text = ''
      =========================
      <-- The Daywatch Site -->
      =========================
    '';
  };

  # Replace the default perl script
  services.userborn.enable = true;

  # Users
  users.users = {
    "ckgxrg" = {
      isNormalUser = true;
      description = "ckgxrg";
      shell = pkgs.nushell;
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
        "gamemode"
        "video"
      ];
    };
  };

  #========== Miscellaneous ==========#
  programs.dconf.enable = true;
  services.udisks2.enable = true;
  virtualisation.waydroid.enable = true;

  # Placeholders
  programs.nano.enable = false;
  programs.hyprland = {
    enable = true;
    systemd.setPath.enable = true;
  };

  # XDG Portal Placeholder
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  # Who'll need this...
  documentation.nixos.enable = false;
}
