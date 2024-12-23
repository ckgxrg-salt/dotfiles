{ pkgs, ... }:
# Settings for hardware related stuff
{
  #========== Hardware ==========#
  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  # Power Button Behaviour
  services.logind = {
    powerKey = "ignore";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };

  #========== Network & Devices ==========#
  # Internet
  networking = {
    # NetworkManager
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    # WireGuard
    wg-quick.interfaces = {
      iof = {
        configFile = "/etc/wireguard/iof.conf";
        autostart = false;
      };
    };

    # Firewall
    firewall = {
      # Localsend
      allowedTCPPorts = [
        53317
      ];
    };
  };

  # Zeroconf
  services.avahi = {
    enable = true;
    openFirewall = true;
    hostName = "Daywatch";

    nssmdns4 = true;
    nssmdns6 = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # CUPS
  services.printing = {
    enable = true;
    stateless = true;
    startWhenNeeded = true;
    drivers = with pkgs; [ hplip ];
  };

  # Android Debug Bridge
  programs.adb.enable = true;

  #========== Audio ==========#
  # PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # Suppress the default impl of xdg sounds
  ckgxrg.themes.sound.enable = true;

  #========== Power ==========#
  # TLP the power saver
  services.tlp = {
    enable = true;
    settings = {
      BAY_POWEROFF_ON_BAT = 1;
    };
  };

  # Other power save features
  services.thermald.enable = true;
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };

  #========== Graphics ==========#
  # OpenGL & Hardware Accleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      libva-vdpau-driver
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      intel-media-driver
      libva-vdpau-driver
    ];
  };
}
