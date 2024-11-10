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
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
  # Suppress the default impl of xdg sounds
  ckgxrg.themes.sound.enable = true;

  # TLP the power saver
  services.tlp = {
    enable = true;
    settings = {
      BAY_POWEROFF_ON_BAT = 1;
    };
  };

  services.thermald.enable = true;

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
