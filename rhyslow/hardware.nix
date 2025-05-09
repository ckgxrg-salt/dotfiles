{
  pkgs,
  config,
  lib,
  ...
}:
# General system configuration
{
  #========== Boot ==========#
  boot = {
    # Setup Secure Boot
    lanzaboote = {
      enable = false;
      pkiBundle = "/etc/secureboot";
    };
    bootspec.enable = true;

    tmp.cleanOnBoot = true;
  };

  #========== Hardware ==========#
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
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
    # Localsend
    firewall = {
      allowedTCPPorts = [ 53317 ];
    };
  };

  # Zeroconf
  services.avahi = {
    enable = true;
    openFirewall = true;
    hostName = "Rhyslow";

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
  # Prevent overheating
  services.thermald.enable = true;

  #========== Graphics ==========#
  # OpenGL & Hardware Accleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  # Nvidia
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    open = true;
    powerManagement = {
      enable = true;
    };
  };
}
