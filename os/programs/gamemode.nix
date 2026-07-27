{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.gamemode;
in
{
  options.program.gamemode = {
    enable = lib.mkEnableOption "Enable Gamemode and Gamescope";
    overclock = lib.mkEnableOption "Let Gamemode apply radical GPU policies";
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        gpu = lib.mkIf cfg.overclock {
          gpu_device = 1;
          apply_gpu_optimisations = "accept-responsibility";
          nv_powermizer_mode = 0;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send -i input-gamepad 'Gamemode Active'";
        };
      };
    };

    users.users."ckgxrg" = {
      extraGroups = [ "gamemode" ];
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
