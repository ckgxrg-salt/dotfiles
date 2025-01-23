{
  config,
  lib,
  pkgs,
  ...
}:
# A unified solution for themes
with lib;
let
  cfg = config.ckgxrg.themes;
in
{
  options.ckgxrg.themes = {
    enable = mkEnableOption "ckgxrg's Theme Configurations";
    gtk = {
      name = mkOption {
        type = types.str;
      };
      pkg = mkOption {
        type = types.package;
      };
    };
    qt = {
      followGTK = mkEnableOption "Use GTK theme for Qt, may not work properly. ";
      name = mkOption {
        type = types.str;
      };
      pkg = mkOption {
        type = types.package;
      };
    };
    cursor = {
      name = mkOption {
        type = types.str;
      };
      size = mkOption {
        type = types.int;
      };
      pkg = mkOption {
        type = types.package;
      };
    };
    icon = {
      name = mkOption {
        type = types.str;
      };
      pkg = mkOption {
        type = types.package;
      };
    };
    font = {
      name = mkOption {
        type = types.str;
      };
      size = mkOption {
        type = types.int;
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

    # Home-manager cursor
    home.pointerCursor = {
      name = cfg.cursor.name;
      package = cfg.cursor.pkg;
    };

    # Qt Style
    qt =
      if cfg.qt.followGTK then
        {
          enable = true;
          platformTheme.name = "gtk2";
          style.name = "gtk2";
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

    # Hyprland Managed Cursor
    home.packages = with pkgs; [ hyprcursor ];
    wayland.windowManager.hyprland.extraConfig = ''
      env = HYPRCURSOR_THEME,${cfg.cursor.name}
      env = HYPRCURSOR_SIZE,${builtins.toString cfg.cursor.size}
      env = XCURSOR_THEME,${cfg.cursor.name}
      env = XCURSOR_SIZE,${builtins.toString cfg.cursor.size}
      env = ICON_THEME,${cfg.icon.name}
    '';
  };
}
