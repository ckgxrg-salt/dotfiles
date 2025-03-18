{ pkgs, ckgs, ... }:
# These options are almost identical on each system
{
  #========== Users ==========#
  # Greet messages
  environment.etc = {
    "issue".text = ''
      ========================
      <-- Radilopa Farland -->
      ========================
    '';
  };

  # Replace the default perl script
  services.userborn.enable = true;

  # ckgxrg's Account
  users.users = {
    ckgxrg = {
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
  # Polkit will not permit operations without this
  environment.shells = with pkgs; [ nushell ];

  secrix.hostIdentityFile = "/home/ckgxrg/.ssh/id_rsa";

  #========== Appearance ==========#
  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts-emoji
      maple-mono-NF
      jost
      libre-bodoni
      ckgs.maple-ui
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Maple Mono NF"
        ];
        sansSerif = [
          "Jost*"
          "Maple UI"
        ];
        serif = [
          "Libre Bodoni"
          "Maple UI"
        ];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <alias>
            <family>Jost*</family>
            <prefer>
              <family>Jost*</family>
              <family>Maple UI</family>
            </prefer>
          </alias>
          <alias>
            <family>Libre Bodoni</family>
            <prefer>
              <family>Libre Bodoni</family>
              <family>Maple UI</family>
            </prefer>
          </alias>
        </fontconfig>
      '';
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
      "ja_JP.UTF-8/UTF-8"
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

  #========== Miscellaneous ==========#
  programs.dconf.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  virtualisation.waydroid.enable = true;
  system.etc.overlay.enable = true;
  programs.nix-ld.enable = true;

  gaming.gamemode = {
    enable = true;
    overclock = true;
    nvidia = true;
  };

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
