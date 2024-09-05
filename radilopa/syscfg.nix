{ pkgs, config, ... }:
# System-wide settings for Radilopa
{
  # My Name!
  networking.hostName = "Radilopa";

  # Power Button Behaviour
  services.logind = {
    powerKey = "lock";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };
  services.systemd-lock-handler.enable = true;

  # Network with NetworkManager
  networking.networkmanager.enable = true;
  networking.wg-quick.interfaces = {
    iof.configFile = "/etc/wireguard/iof.conf";
    iof.autostart = false;
  };
  # A strange fix
  networking.hosts = {
    "0.0.0.0" = [
      "log-upload.mihoyo.com"
      "uspider.yuanshen.com"
      "ys-log-upload.mihoyo.com"
      "dispatchcnglobal.yuanshen.com"
    ];
  };

  # Sound with PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Display Settings
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = [ pkgs.driversi686Linux.mesa ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    prime = {
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:6:0:0";
      sync.enable = true;
    };
  };

  # ckgxrg's Account
  users.users.ckgxrg = {
    isNormalUser = true;
    description = "ckgxrg";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "gamemode" ];
  };

  # Locale, I18n and Fcitx5
  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales =
      [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "en_GB.UTF-8/UTF-8" ];
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
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      powerline-fonts
      wqy_zenhei
      wqy_microhei
      maple-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Maple Mono" "Noto Sans Mono CJK SC" ];
        sansSerif = [ "Maple Mono" "Noto Sans CJK SC" ];
        serif = [ "Maple Mono" "Noto Serif CJK SC" ];
      };
    };
  };

  # Proxychains
  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains;
    proxies = {
      v2raya = {
        type = "socks5";
        host = "127.0.0.1";
        port = 20170;
      };
    };
  };

  # SDDM Session Manager & Gnome Keyring
  environment.systemPackages =
    [ (pkgs.callPackage ../packages/sugar-candy-sddm.nix { }) ];
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.hyprlock = { };
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.libsForQt5.sddm;
    wayland.enable = true;
    theme = "sugar-candy";
  };

  # Polkit Authentication
  security.polkit.enable = true;
  # TLP the power saver
  services.tlp.enable = true;
  # Fwupd
  services.fwupd.enable = true;
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
}
