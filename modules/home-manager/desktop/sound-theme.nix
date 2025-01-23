{
  ckgxrg,
  config,
  lib,
  pkgs,
  ...
}:
# Enable XDG Sound Themes
with lib;
let
  cfg = config.ckgxrg.themes.sound;
in
{
  options.ckgxrg.themes.sound = {
    enable = mkEnableOption "Enable the XDG Sound Themes";
    theme = mkOption {
      type = types.str;
      description = "The Sound Theme name to be used";
      default = "freedesktop";
    };
    package = mkOption {
      type = types.package;
      description = "The Sound Theme package to be used";
      default = pkgs.sound-theme-freedesktop;
    };
    libcanberra = mkOption {
      type = types.package;
      description = "The libcanberra package to be used";
      default = pkgs.libcanberra;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.libcanberra
      cfg.package
    ];
    gtk = {
      gtk2.extraConfig = ''
        gtk-enable-event-sounds=true
        gtk-enable-input-feedback-sounds=true
        gtk-sound-theme-name=${cfg.theme}
      '';
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
