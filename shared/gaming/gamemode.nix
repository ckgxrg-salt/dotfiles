{ pkgs, ... }:
# GameMode and Gamescope
{
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send -i input-gamepad 'GameMode Active'";
      };
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
