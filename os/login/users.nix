{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.login.users;
in
{
  options.login.users = {
    default = lib.mkEnableOption "Apply default users settings";
    issue = lib.mkOption {
      type = lib.types.str;
      description = "Login message";
      default = "Welcome to ${config.device.hostname}.\n";
    };
  };

  config = lib.mkIf cfg.default {
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
  };
}
