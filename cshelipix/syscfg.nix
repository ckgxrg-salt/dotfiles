{ pkgs, ... }:
# System-wide settings for Cshelipix
{
  # My Name!
  networking.hostName = "Cshelipix";
  # Strange messages
  environment.etc."issue".text = ''
                 __
                / /\
               / / /\
              / / /\ \
             / / /\ \ \
  __________/_/_/__\ \ \__________
 /\ \_______________\ \ \_________\
 \ \ \_______________\ \ \________/
  \ \ \  / / /        \ \ \  / / /
   \ \ \/ / /          \ \ \/ / /
    \ \/ / /            \ \/ / /
     \/ / /              \/ / /
     / / /\              / / /\
    / / /\ \            / / /\ \
   / / /\ \ \          / / /\ \ \
  /_/_/__\ \ \________/_/_/__\ \ \
 /________\ \ \---------------\ \ \
 \_________\ \ \_______________\_\/
            \ \ \  / / /
             \ \ \/ / /
              \ \/ / /
               \/ / /
                \/_/
  '';
  environment.etc."motd".text = ''
    <-- Cshelipix Academy of Sorcery -->
  '';

  # Power Button Behaviour
  services.logind = {
    powerKey = "ignore";
    powerKeyLongPress = "reboot";
    lidSwitch = "lock";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
  };
  services.systemd-lock-handler.enable = true;

  # Network with NetworkManager and Firewall with NFTables
  networking.networkmanager.enable = true;
  networking.wg-quick.interfaces = {
    iof.configFile = "/etc/wireguard/iof.conf";
    iof.autostart = false;
  };

  # Bluetooth Support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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

  # ckgxrg's Account
  users.users.ckgxrg = {
    isNormalUser = true;
    description = "ckgxrg";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "gamemode" "video" ];
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

  # Greetd session manager
  imports = [ ../modules/login/greetd.nix ];

  # Polkit Authentication
  security.polkit.enable = true;
  # TLP the power saver
  services.tlp = {
    enable = true;
    settings = { BAY_POWEROFF_ON_BAT = 1; };
  };

  # Display Settings
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = [ pkgs.driversi686Linux.mesa ];
  };

  # Input Remapper
  services.input-remapper = {
    enable = true;
    serviceWantedBy = [];
  };

  # Violent Power Save
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "ondemand";
  };
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
