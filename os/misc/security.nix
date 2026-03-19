{ config, lib, ... }:
with lib;
let
  cfg = config.misc.security;
in
{
  options.misc.security = {
    default = mkEnableOption "Apply default security settings";
  };

  config = mkIf cfg.default {
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

    # Audit Framework
    # security.audit.enable = true;
    # security.auditd.enable = true;

    security.tpm2 = {
      enable = true;
      applyUdevRules = true;
    };

    networking.nftables.enable = true;
    networking.firewall = {
      enable = true;
      trustedInterfaces = mkIf config.virtualisation.waydroid.enable [ "waydroid0" ];
    };
  };
}
