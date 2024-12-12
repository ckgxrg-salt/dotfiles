{ pkgs, config, ... }:
# Settings for hardware related stuff
{
  #========== Hardware ==========#
  hardware = {
    cpu.amd.updateMicrocode = true;
  };

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

  # fwupd
  services.fwupd.enable = true;

  #========== Network & Devices ==========#
  # Internet
  networking = {
    # NetworkManager
    networkmanager = {
      enable = true;
    };

    # WireGuard
    wg-quick.interfaces = {
      iof = {
        configFile = "/etc/wireguard/iof.conf";
        autostart = false;
      };
    };
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
  ckgxrg.themes.sound.enable = true;

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
}
