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
      type = types.lines;
      description = "Message displayed before tty login";
    };
  };

  config = mkIf cfg.default {
    #========== Users ==========#
    # Greet messages
    environment.etc = {
      "issue".text = cfg.issue;
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

    secrix.hostIdentityFile = "/home/ckgxrg/.ssh/id_ed25519";
  };
}
