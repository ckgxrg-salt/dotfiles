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
    cpu = mkOption {
      type = types.oneOf [
        "intel"
        "amd"
      ];
      description = "The host's CPU manufacturer";
    };
    gpu = mkOption {
      type = types.oneOf [
        "intel"
        "amd"
        "nvidia"
      ];
      description = "The host's GPU manufacturer";
    };
    laptop = mkEnableOption "Whether this is a laptop";
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
      cpu.intel.updateMicrocode = (cfg.cpu == "intel");
      cpu.amd.updateMicrocode = (cfg.cpu == "amd");
      enableRedistributableFirmware = true;
    };

    # Power Button Behaviour
    services.logind =
      {
        powerKey = "ignore";
        powerKeyLongPress = "poweroff";
      }
      // optionalAttrs cfg.laptop {
        lidSwitch = "suspend-then-hibernate";
        lidSwitchExternalPower = "suspend";
        lidSwitchDocked = "ignore";
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
      networkmanager = {
        enable = true;
        wifi = {
          backend = "iwd";
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
        fariof = {
          configFile = "/etc/wireguard/fariof.conf";
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

    #========== Power ==========#
    # TLP the power saver
    services.tlp = mkIf cfg.laptop {
      enable = true;
      settings = {
        BAY_POWEROFF_ON_BAT = 1;
      };
    };

    # Other power save features
    services.thermald.enable = cfg.laptop;
    powerManagement = mkIf cfg.laptop {
      enable = true;
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
        ++ optional cfg.gpu == "intel" [
          intel-media-driver
          intel-compute-runtime
        ];
      extraPackages32 =
        with pkgs.driversi686Linux;
        [
          libva-vdpau-driver
        ]
        ++ optional cfg.gpu == "intel" [
          intel-media-driver
        ];
    };
  };
}
