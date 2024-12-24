{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd" = ''
      Welcome from the Welkin - Host
    '';
    "issue" = ''
      Dunno what to say yet...
    '';
  };

  # Replace the default perl script
  services.userborn.enable = true;

  # Users
  users.users = {
    # System administration & maintance
    "akacloud" = {
      isNormalUser = true;
      uid = 1001;
      description = "System administrator";
    };
    "bse" = {
      isNormalUser = true;
      uid = 1002;
      description = "Normal user";
    };
  };
}
