{ config, pkgs, ... }:
{
  # Mako vs Alien
  services.mako = {
    enable = true;
    output = "DP-1";
    anchor = "bottom-right";
    borderRadius = 0;
    backgroundColor = "#8fbcbb66";
    borderColor = "#4c566a66";
    defaultTimeout = 15000;
    font = "maple mono 12";
    height = 150;
    width = 450;
    icons = true;
    maxIconSize = 64;
    maxVisible = 3;
    iconPath = "${config.home.profileDirectory}/share/icons/${config.theme.icon.name}";
  };

  # Mako's icons
  xdg.configFile = {
    "mako/icons/brightness-20.png".source = ../../../assets/brightness-20.png;
    "mako/icons/brightness-40.png".source = ../../../assets/brightness-40.png;
    "mako/icons/brightness-60.png".source = ../../../assets/brightness-60.png;
    "mako/icons/brightness-80.png".source = ../../../assets/brightness-80.png;
    "mako/icons/brightness-100.png".source = ../../../assets/brightness-100.png;
    "mako/icons/volume-high.png".source = ../../../assets/volume-high.png;
    "mako/icons/volume-low.png".source = ../../../assets/volume-low.png;
    "mako/icons/volume-mid.png".source = ../../../assets/volume-mid.png;
    "mako/icons/volume-mute.png".source = ../../../assets/volume-mute.png;
  };

  # Run as daemon
  systemd.user.services."mako" = {
    Unit = {
      Description = "Lightweight Wayland notification daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.mako}/bin/mako";
      ExecReload = "${pkgs.mako}/bin/makoctl reload";
      Restart = "on-failure";
      Slice = "background-graphical.slice";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
