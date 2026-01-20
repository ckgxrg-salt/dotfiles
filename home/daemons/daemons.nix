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
    cliphist.enable = mkEnableOption "Enable cliphist clipboard manager";
    iwgtk.enable = mkEnableOption "Enable iwgtk tray applet";
    udiskie.enable = mkEnableOption "Enable udiskie device manager";
    polkit-gnome-agent.enable = mkEnableOption "Enable the GNOME polkit agent";
    wvkbd.enable = mkEnableOption "Enable wvkbd virtual keyboard";
  };

  config = {
    # Accessories packages
    home.packages =
      with pkgs;
      optionals cfg.cliphist.enable [
        cliphist
        wl-clipboard
      ]
      ++ optionals cfg.iwgtk.enable [
        iwgtk
      ];

    xdg.configFile = mkIf cfg.udiskie.enable {
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
      "cliphist" = mkIf cfg.cliphist.enable (mkDaemon {
        desc = "Clipboard History Manager";
        exec = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      });

      # Virtual keyboard
      "wvkbd" = mkIf cfg.wvkbd.enable (mkDaemon {
        desc = "Virtual Keyboard";
        exec = "${ckgs.wvkbd}/bin/wvkbd-vistath --hidden -L 500";
      });

      # iwgtk
      "iwgtk" = mkIf cfg.iwgtk.enable (mkDaemon {
        desc = "iwgtk Daemon";
        exec = "${pkgs.iwgtk}/bin/iwgtk -i";
      });

      # Udiskie Automount
      "udiskie" = mkIf cfg.udiskie.enable (mkDaemon {
        desc = "Udiskie Auto Mount Manager";
        exec = "${pkgs.udiskie}/bin/udiskie --event-hook \"canberra-gtk-play -i device-added\"";
      });

      # Polkit Authentication Agent
      "polkit-gnome-agent" = mkIf cfg.polkit-gnome-agent.enable (mkDaemon {
        desc = "GNOME's Polkit Authentication Agent";
        exec = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      });
    };
  };
}
