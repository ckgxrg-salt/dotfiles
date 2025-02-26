{
  pkgs,
  config,
  lib,
  ...
}:
# General system configuration
{
  #========== Hardware ==========#
  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  # Power Button Behaviour
  services.logind = {
    powerKey = "ignore";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend";
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
      allowedTCPPorts = [
        5900
        53317
      ];
    };
  };

  # Zeroconf
  services.avahi = {
    enable = true;
    openFirewall = true;
    hostName = "Radilopa";

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
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  # Suppress the default impl of xdg sounds
  theme.sound.enable = true;

  #========== Power ==========#
  # TLP the power saver
  services.tlp = {
    enable = true;
    settings = {
      BAY_POWEROFF_ON_BAT = 1;
    };
  };

  # Prevent overheating
  services.thermald.enable = true;

  #========== Graphics ==========#
  # OpenGL & Hardware Accleration
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

  # Nvidia
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    dpi = 189;
  };
  hardware.nvidia = {
    open = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    dynamicBoost.enable = true;
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

  #========== Miscellaneous ==========#
  gaming.gamemode = {
    enable = true;
    overclock = true;
    nvidia = true;
  };

  # It wont work on NVIDIA
  virtualisation.waydroid.enable = lib.mkForce false;
}
