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
    issue = mkOption {
      type = types.str;
      description = "Login message";
      default = "Welcome to ${config.device.hostname}.\n";
    };
  };

  config = mkIf cfg.default {
    # Greet messages
    environment.etc = {
      "issue".text = cfg.issue;
    };

    users.users = {
      "ckgxrg" = {
        isNormalUser = true;
        description = "ckgxrg";
        shell = pkgs.nushell;
        extraGroups = [
          "wheel"
          "input"
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
