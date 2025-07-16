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
    }:
    {
      Unit = {
        Description = desc;
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = exec;
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
in
{
  options.daemons = {
    cliphist = mkEnableOption "Enable cliphist clipboard manager";
    nm-applet = mkEnableOption "Enable the networkmanager applet";
    udiskie = mkEnableOption "Enable udiskie device manager";
    polkit-gnome-agent = mkEnableOption "Enable the GNOME polkit agent";
    wvkbd = mkEnableOption "Enable wvkbd virtual keyboard";
  };

  config = {
    # Accessories packages
    home.packages = optionals cfg.cliphist [
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
    };

    systemd.user.services = {
      # Cliphist the clipboard manager
      "cliphist" = mkIf cfg.cliphist (mkDaemon {
        desc = "Clipboard History Manager";
        exec = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      });

      # Virtual keyboard
      "wvkbd" = mkIf cfg.wvkbd (mkDaemon {
        desc = "Virtual Keyboard";
        exec = "${ckgs.wvkbd}/bin/wvkbd-vistath --hidden -L 500";
      });

      # NetworkManager Applet
      "nm-applet" = mkIf cfg.nm-applet (mkDaemon {
        desc = "NetworkManager Applet";
        exec = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      });

      # Udiskie Automount
      "udiskie" = mkIf cfg.udiskie (mkDaemon {
        desc = "Udiskie Auto Mount Manager";
        exec = "${pkgs.udiskie}/bin/udiskie --event-hook \"canberra-gtk-play -i device-added\"";
      });

      # Polkit Authentication Agent
      "polkit-gnome-agent" = mkIf cfg.polkit-gnome-agent (mkDaemon {
        desc = "GNOME's Polkit Authentication Agent";
        exec = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      });
    };
  };
}
