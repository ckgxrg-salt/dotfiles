{
  config,
  lib,
  pkgs,
  ckgs,
  ...
}:
with lib;
let
  cfg = config.daemons;
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
  options.daemons = {
    astal = mkEnableOption "Enable Astal desktop widgets";
    cliphist = mkEnableOption "Enable cliphist clipboard manager";
    nm-applet = mkEnableOption "Enable the networkmanager applet";
    udiskie = mkEnableOption "Enable udiskie device manager";
    polkit-gnome-agent = mkEnableOption "Enable the GNOME polkit agent";
  };

  config = {
    # Accessories packages
    home.packages =
      optionals cfg.astal [
        ckgs.astal.daywatch
        ckgs.astal.daywatch-logout
      ]
      ++ optionals cfg.cliphist [
        pkgs.cliphist
        pkgs.wl-clipboard
      ];

    xdg.configFile = mkIf cfg.udiskie {
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
      '';
    };

    systemd.user.services = {
      # Astal desktop shell
      "astal" = mkIf cfg.astal (mkDaemon {
        desc = "Astal Desktop Widgets";
        exec = "${ckgs.astal.daywatch}/bin/daywatch-astal";
        slice = "background-graphical.slice";
      });

      # Cliphist the clipboard manager
      "cliphist" = mkIf cfg.cliphist (mkDaemon {
        desc = "Clipboard History Manager";
        exec = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
        slice = "background-graphical.slice";
      });

      # NetworkManager Applet
      "nm-applet" = mkIf cfg.nm-applet (mkDaemon {
        desc = "NetworkManager Applet";
        exec = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        slice = "app-graphical.slice";
      });

      # Udiskie Automount
      "udiskie" = mkIf cfg.udiskie (mkDaemon {
        desc = "Udiskie Auto Mount Manager";
        exec = "${pkgs.udiskie}/bin/udiskie --event-hook \"canberra-gtk-play -i device-added\"";
        slice = "app-graphical.slice";
      });

      # Polkit Authentication Agent
      "polkit-gnome-agent" = mkIf cfg.polkit-gnome-agent (mkDaemon {
        desc = "GNOME's Polkit Authentication Agent";
        exec = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        slice = "app-graphical.slice";
      });
    };
  };
}
