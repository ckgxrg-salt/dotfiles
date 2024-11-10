{ pkgs, ... }:
# System-wide settings for Daywarden
{

  # Network with NetworkManager
  networking.networkmanager.enable = true;
  networking.wg-quick.interfaces = {
    iof = {
      configFile = "/etc/wireguard/iof.conf";
      autostart = false;
    };
  };

  # Allow KDE Connect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  # Locale, I18n and Fcitx5
  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "zh_CN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # System Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      powerline-fonts
      maple-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Maple Mono"
          "Noto Sans Mono CJK SC"
        ];
        sansSerif = [
          "Maple Mono"
          "Noto Sans CJK SC"
        ];
        serif = [
          "Maple Mono"
          "Noto Serif CJK SC"
        ];
      };
    };
  };

  # Polkit Authentication
  security.polkit.enable = true;

  # dconf
  programs.dconf.enable = true;
  # Auto-Mount Backend
  services.udisks2.enable = true;
  # Nix-ld
  programs.nix-ld.enable = true;
  # Waydroid Emulator
  virtualisation.waydroid.enable = true;

  # MPD daemon
  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
          type "pipewire"
          name "PipeWire Output"
      }
    '';
  };

  documentation.nixos.enable = false;
}
