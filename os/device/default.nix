{ config, lib, ... }:
{
  options.device = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Hostname for the device";
    };
    laptop = lib.mkEnableOption "Whether this is a laptop";
    version = lib.mkOption {
      type = lib.types.str;
      description = "NixOS version";
    };
    hostCPU = lib.mkOption {
      type = lib.types.enum [
        "intel"
        "amd"
      ];
      description = "The host's CPU manufacturer";
    };
  };

  config = {
    networking.hostName = config.device.hostname;
    system.stateVersion = config.device.version;

    hardware = {
      cpu.intel.updateMicrocode = (config.device.hostCPU == "intel");
      cpu.amd.updateMicrocode = (config.device.hostCPU == "amd");
      enableRedistributableFirmware = true;
    };

    services.libinput = {
      enable = true;
    };
  };
}
