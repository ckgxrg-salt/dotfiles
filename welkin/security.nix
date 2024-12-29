{ ... }:
# Security configuration
{
  # SSH to the host should be strictly limited
  programs.openssh = {
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
  # Only allow Daywatch and Radilopa
  users.users = {
    "akacloud".openssh.authorizedKeys.keys = [
      ./keys/daywatch-ssh.pub
    ];
  };
}
