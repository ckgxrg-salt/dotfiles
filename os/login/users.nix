{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.login = {
    issue = lib.mkOption {
      type = lib.types.str;
      description = "Login message";
      default = "Welcome to ${config.device.hostname}.\n";
    };
  };

  config = {
    # Greet messages
    environment.etc = {
      "issue".text = config.login.issue;
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
