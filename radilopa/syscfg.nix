{
  pkgs,
  config,
  ...
}:
# System-wide settings for Radilopa
{
  # Replace the default perl script
  services.userborn.enable = true;

  # Power Button Behaviour
  services.logind = {
    powerKey = "lock";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };
  # Let logind summon wlogout menu instead
  services.systemd-lock-handler.enable = true;

  # Network with NetworkManager
  networking.networkmanager.enable = true;
  networking.wg-quick.interfaces = {
    iof = {
      configFile = "/etc/wireguard/iof.conf";
      autostart = false;
    };
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
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
  # Suppress the default impl of xdg sounds
  ckgxrg.themes.sound.enable = true;

  # Display Settings
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libva-vdpau-driver
      amdvlk
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      libva-vdpau-driver
      amdvlk
    ];
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    dpi = 189;
  };
  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    prime = {
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:6:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  # ckgxrg's Account
  users.users.ckgxrg = {
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

  # SDDM Session Manager
  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      breeze-icons
      kirigami
      plasma5support
      qtsvg
      qtvirtualkeyboard
    ];
  };

  # dconf
  programs.dconf.enable = true;
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
  # Cooling
  services.thermald.enable = true;

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
