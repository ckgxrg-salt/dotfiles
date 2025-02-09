{ pkgs, lib, ... }:
# Settings for hardware related stuff
{
  #========== Hardware ==========#
  hardware = {
    cpu.intel.updateMicrocode = true;
    intelgpu = {
      driver = "i915";
      vaapiDriver = "intel-media-driver";
    };
  };

  # ZFS
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
  services.fstrim.enable = false;

  # Power Button Behaviour
  services.logind = {
    powerKey = "ignore";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };

  # Mouse & Touchpad
  services.libinput = {
    enable = true;
  };

  #========== Network & Devices ==========#
  # Internet
  networking = {
    # NetworkManager
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
      };
      plugins = lib.mkForce [ ];
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
    hostName = "Vistath";

    nssmdns4 = true;
    nssmdns6 = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

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
  theme.sound.enable = true;

  #========== Power ==========#
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
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      intel-media-driver
    ];
  };

  #========== Users ==========#
  # Greet messages
  environment.etc = {
    "issue".text = ''
      ==========================
      <-- The Vistath Garden -->
      ==========================
    '';
  };

  # Users
  users.users = {
    "ckgxrg" = {
      isNormalUser = true;
      description = "ckgxrg";
      shell = pkgs.nushell;
      extraGroups = [
        "networkmanager"
        "surface-control"
        "wheel"
        "input"
        "gamemode"
        "video"
      ];
    };
  };
  # Polkit will not permit operations without this
  environment.shells = with pkgs; [ nushell ];

  #========== Miscellaneous ==========#
  gaming.gamemode = {
    enable = true;
  };
}
