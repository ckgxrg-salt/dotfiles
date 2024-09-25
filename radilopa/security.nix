{ ... }:
# Security configuraions
{
  # sudo
  security.sudo = {
    enable = true;
    execWheelOnly = true;
    extraConfig = ''
      Defaults passprompt="Enter Password for %p to Continue: "
      Defaults insults
      Defaults pwfeedback
    '';
  };

  # Gnome Keyring
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services.hyprlock = { };

  # AppArmor MAC
  security.apparmor = {
    enable = true;
    enableCache = true;
  };
  services.dbus = {
    apparmor = "enabled";
    implementation = "broker";
  };

  # TPM2 Support
  boot.initrd.systemd.enableTpm2 = true;
  security.tpm2 = {
    enable = true;
    applyUdevRules = true;
  };

  # Firewall with NFTables
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "waydroid0" ];
  };
}
