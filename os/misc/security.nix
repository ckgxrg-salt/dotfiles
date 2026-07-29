{ config, lib, ... }:
{
  config = {
    security.sudo = {
      enable = true;
      execWheelOnly = true;
      extraConfig = ''
        Defaults passprompt="Enter Password for %p to Continue: "
        Defaults insults
        Defaults pwfeedback
      '';
    };

    security.polkit.enable = true;
    services.pcscd.enable = true;

    security.apparmor = {
      enable = true;
      enableCache = true;
    };
    services.dbus = {
      apparmor = "enabled";
      implementation = "broker";
    };

    security.tpm2 = {
      enable = true;
      applyUdevRules = true;
    };

    networking.nftables.enable = true;
    networking.firewall = {
      enable = true;
      trustedInterfaces = lib.mkIf config.virtualisation.waydroid.enable [ "waydroid0" ];
    };
  };
}
