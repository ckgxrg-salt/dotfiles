{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.login.users;
in
{
  options.login.users = {
    default = mkEnableOption "Apply default users settings";
  };

  config = mkIf cfg.default {
    # Greet messages
    environment.etc = {
      "issue".text = "Welcome to ${config.device.hostname}.\n";
    };

    # Users
    users.users = {
      "ckgxrg" = {
        isNormalUser = true;
        description = "ckgxrg";
        shell = pkgs.nushell;
        extraGroups = [
          "networkmanager"
          "wheel"
          "input"
          "gamemode"
          "video"
        ];
      };
    };
    # Polkit will not permit operations without this
    environment.shells = with pkgs; [ nushell ];

    # Replace the default perl script
    services.userborn.enable = true;
  };
}
