{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Host
    '';
    "issue".text = ''
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
      extraGroups = [ "wheel" ];
      description = "System administrator";
    };
    # The target colmena will ssh into
    "deployer" = {
      isNormalUser = true;
      uid = 1002;
      extraGroups = [ "wheel" ];
      description = "Colmena deployer";
    };
  };
}
