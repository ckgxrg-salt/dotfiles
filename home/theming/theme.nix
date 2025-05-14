{
  config,
  lib,
  ...
}:
# A unified solution for themes
with lib;
let
  cfg = config.theme;
in
{
  options.theme = {
    enable = mkEnableOption "ckgxrg's theme configurations";
    gtk = {
      name = mkOption {
        type = types.str;
        description = "The GTK theme name to use";
      };
      pkg = mkOption {
        type = types.package;
        description = "The GTK theme package to use";
      };
    };
    qt = {
      followGTK = mkEnableOption "Use GTK theme for Qt, may not work properly";
      name = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "The Qt(Kvantum) theme name to use";
      };
      pkg = mkOption {
        type = types.nullOr types.package;
        default = null;
        description = "The Qt(Kvantum) theme package to use";
      };
    };
    cursor = {
      name = mkOption {
        type = types.str;
        description = "The cursor theme name to use";
      };
      size = mkOption {
        type = types.int;
        description = "The cursor size";
      };
      pkg = mkOption {
        type = types.package;
        description = "The cursor theme package to use";
      };
    };
    icon = {
      name = mkOption {
        type = types.str;
        description = "The icon theme name to use";
      };
      pkg = mkOption {
        type = types.package;
        description = "The icon theme package to use";
      };
    };
    font = {
      name = mkOption {
        type = types.str;
        description = "Font used in userspace";
      };
      size = mkOption {
        type = types.int;
        description = "Font size";
      };
    };
  };

  config = mkIf cfg.enable {
    warnings =
      if (cfg.qt.followGTK && (cfg.qt.name != null)) then
        [ "Qt is following GTK theme, the indicated Qt theme will be invalid. " ]
      else
        [ ];
    # GTK Look and Feel
    gtk = {
      enable = (cfg.gtk != null);
      theme = {
        name = cfg.gtk.name;
        package = cfg.gtk.pkg;
      };
      cursorTheme = {
        name = cfg.cursor.name;
        package = cfg.cursor.pkg;
      };
      font = {
        name = cfg.font.name;
        size = cfg.font.size;
      };
      iconTheme = {
        name = cfg.icon.name;
        package = cfg.icon.pkg;
      };
    };

    # Qt Style
    qt =
      if cfg.qt.followGTK then
        {
          enable = true;
          platformTheme.name = "gtk3";
        }
      else
        {
          enable = true;
          platformTheme.name = "qtct";
          style.name = "kvantum";
        };

    xdg.configFile = mkIf (!cfg.qt.followGTK) {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=${cfg.qt.name}
      '';

      "Kvantum/${cfg.qt.name}".source = "${cfg.qt.pkg}/share/Kvantum/${cfg.qt.name}";
    };

    # Home-manager cursor
    home.pointerCursor = {
      name = cfg.cursor.name;
      package = cfg.cursor.pkg;
      size = cfg.cursor.size;
      hyprcursor.enable = true;
    };
  };
}
