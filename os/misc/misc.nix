{ config, lib, ... }:
with lib;
let
  cfg = config.misc;
in
{
  options.misc.default = mkEnableOption "Enable default miscellaneous settings";

  config = mkIf cfg.default {
    # Placeholders
    programs.dconf.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    system.etc.overlay.enable = true;
    programs.nix-ld.enable = true;
    programs.hyprland.enable = true;

    systemd = {
      oomd.enable = false;
      coredump.enable = !config.boot.noCoredump;
    };

    # Who'll need this...
    documentation = {
      nixos.enable = false;
      info.enable = false;
    };
    programs.nano.enable = false;
    programs.command-not-found.enable = false;
    fonts.enableDefaultPackages = false;
    environment.defaultPackages = [ ];
    services.speechd.enable = false;
    system.tools.nixos-option.enable = false;
  };
}
