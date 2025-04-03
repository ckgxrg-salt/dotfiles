{
  config,
  pkgs,
  daywatch-astal,
  ...
}:
# Accessories that run as daemons
let
  mkDaemon =
    {
      desc,
      exec,
      slice,
    }:
    {
      Unit = {
        Description = desc;
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = exec;
        Restart = "on-failure";
        Slice = slice;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
in
{
  # Accessories packages
  home.packages = with pkgs; [
    grimblast
    brightnessctl
    playerctl
    libnotify
    wl-clipboard
    cliphist

    daywatch-astal.packages.x86_64-linux.default
    daywatch-astal.packages.x86_64-linux.logout
  ];

  xdg.configFile = {
    # udiskie the Auto-Mount Manager, sadly Nix is problematic dealing with order of options
    "udiskie/config.yml".text = ''
      device_config:
      - device_file: /dev/loop*
        ignore: true
      program_options:
        automount: true
        notify: true
        tray: auto
    '';

    # Waypaper
    "waypaper/config.ini".text = ''
      [Settings]
      folder = ${config.xdg.userDirs.pictures}/Wallpapers
      fill = Fill
      sort = name
      backend = swww
      color = #ffffff
      subfolders = true
      monitors = eDP-1
      swww_transition_type = wipe
      swww_transition_angle = 30
    '';
  };

  systemd.user.services = {
    # Astal desktop shell
    "astal" = mkDaemon {
      desc = "Astal Desktop Widgets";
      exec = "${daywatch-astal.packages.x86_64-linux.default}/bin/daywatch-astal";
      slice = "background-graphical.slice";
    };

    # Cliphist the clipboard manager
    "cliphist" = mkDaemon {
      desc = "Clipboard History Manager";
      exec = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      slice = "background-graphical.slice";
    };

    # NetworkManager Applet
    "nm-applet" = mkDaemon {
      desc = "NetworkManager Applet";
      exec = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      slice = "app-graphical.slice";
    };

    # Udiskie Automount
    "udiskie" = mkDaemon {
      desc = "Udiskie Auto Mount Manager";
      exec = "${pkgs.udiskie}/bin/udiskie --event-hook \"canberra-gtk-play -i device-added\"";
      slice = "app-graphical.slice";
    };

    # Polkit Authentication Agent
    "polkit-gnome-agent" = mkDaemon {
      desc = "GNOME's Polkit Authentication Agent";
      exec = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      slice = "app-graphical.slice";
    };
  };
}
