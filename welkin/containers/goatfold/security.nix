{ ... }:
# Security configuration
{
  # SSH
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    openFirewall = true;

    settings = {
      X11Forwarding = false;
      UsePAM = true;
      PrintMotd = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  # Only allow Daywatch and Radilopa to access the host
  users.users = {
    "akacloud".openssh.authorizedKeys.keyFiles = [
      ../../keys/daywatch-ssh.pub
    ];
    "goat".openssh.authorizedKeys.keyFiles = [
      ../../keys/daywatch-ssh.pub
    ];
  };

  # sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };

  # Firewall with NFTables
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    # Everyone knows what is this
    allowedTCPPorts = [ 25565 ];
  };

  # AppArmor MAC
  security.apparmor = {
    enable = true;
    enableCache = true;
  };
  services.dbus = {
    apparmor = "enabled";
    implementation = "broker";
  };

  # Audit Framework
  security.auditd.enable = true;
}