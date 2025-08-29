{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.hardware;
in
{
  options.hardware = {
    default = mkEnableOption "Apply default hardware settings";
    secureBoot = mkEnableOption "Enable secureboot, must be set up manually";
    hostCPU = mkOption {
      type = types.enum [
        "intel"
        "amd"
      ];
      description = "The host's CPU manufacturer";
    };
    hostGPU = mkOption {
      type = types.enum [
        "intel"
        "amd"
        "nvidia"
      ];
      description = "The host's GPU manufacturer";
    };
    laptop = mkEnableOption "Whether this is a laptop";
    tlp = mkEnableOption "Whether to use TLP power saver";
    wifi = mkEnableOption "Whether to support wireless network";
    bt = mkEnableOption "Whether to support Bluetooth";
  };

  config = mkIf cfg.default {
    #========== Boot ==========#
    boot = {
      # Setup Secure Boot
      lanzaboote = {
        enable = cfg.secureBoot;
        pkiBundle = "/etc/secureboot";
      };
      bootspec.enable = true;
      tmp.cleanOnBoot = true;
    };

    #========== Hardware ==========#
    hardware = {
      cpu.intel.updateMicrocode = (cfg.hostCPU == "intel");
      cpu.amd.updateMicrocode = (cfg.hostCPU == "amd");
      enableRedistributableFirmware = true;
    };

    # Power Button Behaviour
    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "poweroff";
    }
    // optionalAttrs cfg.laptop {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };

    # Let astal monitor battery
    services.upower = mkIf cfg.laptop {
      enable = true;
      percentageLow = 10;
      percentageAction = 3;
    };

    # Mouse & Touchpad
    services.libinput = {
      enable = true;
    };

    #========== Network & Devices ==========#
    # Internet
    networking = {
      # NetworkManager
      networkmanager = mkIf cfg.wifi {
        enable = true;
        wifi = {
          backend = "iwd";
          powersave = true;
        };
        plugins = lib.mkForce [ ];
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
      nssmdns4 = true;
      nssmdns6 = true;
    };

    # Bluetooth
    hardware.bluetooth = mkIf cfg.bt {
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

    #========== Power ==========#
    # TLP the power saver
    services.tlp = mkIf cfg.tlp {
      enable = true;
      settings = {
        BAY_POWEROFF_ON_BAT = 1;
      };
    };

    # Other power save features
    services.thermald.enable = cfg.hostCPU == "intel";
    powerManagement = {
      enable = true;
    }
    // optionalAttrs cfg.laptop {
      powertop.enable = true;
      cpuFreqGovernor = "powersave";
    };

    #========== Graphics ==========#
    # OpenGL & Hardware Accleration
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages =
        with pkgs;
        [
          libva-vdpau-driver
        ]
        ++ optionals (cfg.hostGPU == "intel") [
          intel-media-driver
          intel-compute-runtime
        ]
        ++ optionals (cfg.hostGPU == "nvidia") [
          nvidia-vaapi-driver
        ];
      extraPackages32 =
        with pkgs.driversi686Linux;
        [
          libva-vdpau-driver
        ]
        ++ optionals (cfg.hostGPU == "intel") [
          intel-media-driver
        ];
    };

    services.xserver = mkIf (cfg.hostGPU == "nvidia") {
      videoDrivers = [ "nvidia" ];
    };
    hardware.nvidia = mkIf (cfg.hostGPU == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      open = true;
      powerManagement.enable = true;
    };
  };
}
