{ pkgs, ... }:
{
  config = {
    # Override system default XDG sounds
    xdg.sounds.enable = false;
    environment.pathsToLink = [
      "/share/sounds"
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];

    # Placeholders
    programs.dconf.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    programs.nix-ld.enable = true;

    systemd = {
      oomd.enable = false;
      coredump.enable = false;
    };

    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];

    # Who'll need this...
    documentation = {
      nixos.enable = false;
      info.enable = false;
    };
    programs.nano.enable = false;
    programs.command-not-found.enable = false;
    fonts.enableDefaultPackages = false;
    environment.defaultPackages = [ ];
    system.tools.nixos-option.enable = false;
  };
}
