{
  config,
  lib,
  pkgs,
  ...
}:
# Enable XDG Sound Themes
let
  cfg = config.theme.sound;
in
{
  options.theme.sound = {
    enable = lib.mkEnableOption "Enable the XDG Sound Themes";
    theme = lib.mkOption {
      type = lib.ltypes.str;
      description = "The Sound Theme name to be used";
      default = "freedesktop";
    };
    package = lib.mkOption {
      type = lib.types.package;
      description = "The Sound Theme package to be used";
      default = pkgs.sound-theme-freedesktop;
    };
    libcanberra = lib.mkOption {
      type = lib.types.package;
      description = "The libcanberra package to be used";
      default = pkgs.libcanberra;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.libcanberra
      cfg.package
    ];
    gtk = {
      gtk3.extraConfig = {
        gtk-enable-event-sounds = true;
        gtk-enable-input-feedback-sounds = true;
        gtk-sound-theme-name = cfg.theme;
      };
      gtk4.extraConfig = {
        gtk-enable-event-sounds = true;
        gtk-enable-input-feedback-sounds = true;
        gtk-sound-theme-name = cfg.theme;
      };
    };
  };
}
