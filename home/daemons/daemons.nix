{
  config,
  lib,
  pkgs,
  ckgs,
  ...
}:
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
    cliphist.enable = lib.mkEnableOption "Enable cliphist clipboard manager";
    udiskie.enable = lib.mkEnableOption "Enable udiskie device manager";
    polkit-gnome-agent.enable = lib.mkEnableOption "Enable the GNOME polkit agent";
    wvkbd.enable = lib.mkEnableOption "Enable wvkbd virtual keyboard";
  };

  config = {
    # Accessories packages
    home.packages =
      with pkgs;
      lib.optionals cfg.cliphist.enable [
        cliphist
        wl-clipboard
      ];

    xdg.configFile = lib.mkIf cfg.udiskie.enable {
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
      "cliphist" = lib.mkIf cfg.cliphist.enable (mkDaemon {
        desc = "Clipboard History Manager";
        exec = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      });

      # Virtual keyboard
      "wvkbd" = lib.mkIf cfg.wvkbd.enable (mkDaemon {
        desc = "Virtual Keyboard";
        exec = "${ckgs.wvkbd}/bin/wvkbd-vistath --hidden -L 500";
      });

      # Udiskie Automount
      "udiskie" = lib.mkIf cfg.udiskie.enable (mkDaemon {
        desc = "Udiskie Auto Mount Manager";
        exec = "${pkgs.udiskie}/bin/udiskie --event-hook \"canberra-gtk-play -i device-added\"";
      });

      # Polkit Authentication Agent
      "polkit-gnome-agent" = lib.mkIf cfg.polkit-gnome-agent.enable (mkDaemon {
        desc = "GNOME's Polkit Authentication Agent";
        exec = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      });
    };
  };
}
