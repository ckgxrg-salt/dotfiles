{ pkgs, ckgs, ... }:
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

  # Allow Localsend 
  networking.firewall = rec {
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = allowedTCPPorts;
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

  # System Fonts
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

  # dconf
  programs.dconf.enable = true;
  # Auto-Mount Backend
  services.udisks2.enable = true;
  # Nix-ld
  programs.nix-ld.enable = true;
  # Waydroid Emulator
  virtualisation.waydroid.enable = true;

  documentation.nixos.enable = false;
}
