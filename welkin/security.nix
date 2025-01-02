{ ... }:
# Security configuration
{
  # SSH to the host should be strictly limited
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
      ./keys/daywatch-ssh.pub
    ];
  };

  # sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    execWheelOnly = true;
    extraRules = [
      # Allow remote deployment to use the command without password
      {
        users = [ "akacloud" ];
        commands = [
          {
            command = "nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
