{ config, lib, ... }:
with lib;
let
  cfg = config.misc;
in
{
  options.misc.default = mkEnableOption "Enable default miscellaneous settings";

  config = mkIf cfg.default {
    programs.dconf.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    system.etc.overlay.enable = true;
    programs.nix-ld.enable = true;

    systemd = {
      oomd.enable = false;
      coredump.enable = !config.boot.noCoredump;
    };

    fonts.enableDefaultPackages = false;

    # Placeholders
    programs.nano.enable = false;
    programs.command-not-found.enable = false;
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      systemd.setPath.enable = true;
    };

    # XDG Portal Placeholder
    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];

    # Who'll need this...
    documentation = {
      nixos.enable = false;
      info.enable = false;
    };
    environment.defaultPackages = [ ];
    services.speechd.enable = false;
    system.tools.nixos-option.enable = false;
  };
}
