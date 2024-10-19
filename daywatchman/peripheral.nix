{ pkgs, ... }:
{
  # Power Button Behaviour
  services.logind = {
    powerKey = "lock";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };
  services.systemd-lock-handler.enable = true;

  # Bluetooth Support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # CUPS for printers support
  services.printing = {
    enable = true;
    stateless = true;
    startWhenNeeded = true;
    drivers = with pkgs; [ hplip ];
  };

  # Connect with Android
  programs.adb.enable = true;

  # Sound with PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # TLP the power saver
  services.tlp = {
    enable = true;
    settings = {
      BAY_POWEROFF_ON_BAT = 1;
    };
  };

  services.thermald = {
    enable = true;
  };

  # Violent Power Save
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "ondemand";
  };

  # Display Settings
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      intel-media-driver
      intel-compute-runtime
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      mesa
      intel-media-driver
    ];
  };
}
