{
  ckgxrg,
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
    guideMako = mkOption {
      type = types.bool;
      default = false;
    };
    withFlatpak = mkOption {
      type = types.bool;
      default = false;
    };
    gtk = {
      name = mkOption {
        type = types.str;
      };
      pkg = mkOption {
        type = types.package;
      };
    };
    qt = {
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
    qt = {
      enable = (cfg.qt != null);
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
    xdg.configFile = {
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

    # Mako vs Alien paths
    services.mako.iconPath = mkIf cfg.guideMako "${config.home.profileDirectory}/share/icons/${cfg.icon.name}";

    # Then make them availiable to Flatpaks
    home.activation = mkIf cfg.withFlatpak {
      fixFlatpakThemes = ''
        run mkdir -p ${config.home.homeDirectory}/.icons
        run mkdir -p ${config.home.homeDirectory}/.themes
        run rm -rf ${config.home.homeDirectory}/.icons/*
        run rm -rf ${config.home.homeDirectory}/.themes/*
        run ln -sfT ${cfg.icon.pkg}/share/icons/${cfg.icon.name} /home/ckgxrg/.icons/${cfg.icon.name}
        run ln -sfT ${cfg.cursor.pkg}/share/icons/${cfg.cursor.name} /home/ckgxrg/.icons/${cfg.cursor.name}
        run ln -sfT ${cfg.gtk.pkg}/share/themes/${cfg.gtk.name} /home/ckgxrg/.themes/${cfg.gtk.name}
      '';
    };
    services.flatpak.overrides = mkIf cfg.withFlatpak {
      global = {
        # Force Wayland
        Context.sockets = [
          "wayland"
          "!x11"
          "fallback-x11"
        ];
        # Make files accessible to flatpaks
        Context.filesystems = [
          "${config.home.homeDirectory}/.themes:ro"
          "${config.home.homeDirectory}/.icons:ro"
          "${cfg.gtk.pkg}/share/themes:ro"
          "${cfg.icon.pkg}/share/icons:ro"
          "${cfg.cursor.pkg}/share/icons:ro"
          "xdg-config/Kvantum:ro"
        ];
        # Set themes
        Environment = {
          "GTK_THEME" = cfg.gtk.name;
          "ICON_THEME" = cfg.icon.name;
          "QT_STYLE_OVERRIDE" = "kvantum";
          "HYPRCURSOR_THEME" = cfg.cursor.name;
          "HYPRCURSOR_SIZE" = (builtins.toString cfg.cursor.size);
          "XCURSOR_PATH" = "${cfg.cursor.pkg}/share/icons";
          "XCURSOR_THEME" = cfg.cursor.name;
          "XCURSOR_SIZE" = (builtins.toString cfg.cursor.size);
        };
      };
    };
  };
}
