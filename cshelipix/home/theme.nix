{ pkgs, ... }:
# Define theme names and pkgs here
let
  gtkTheme = "Fluent-teal-Dark";
  gtkPkg = pkgs.fluent-gtk-theme.override {
    themeVariants = [ "teal" ];
    colorVariants = [ "dark" ];
    sizeVariants = [ "standard" ];
  };

  qtStyle = "Catppuccin-Mocha-Sapphire";
  qtPkg = pkgs.catppuccin-kvantum.override {
    accent = "Sapphire";
    variant = "Mocha";
  };

  cursor = "GoogleDot-Black";
  cursorPkg = (pkgs.callPackage ../../packages/googledot-cursor.nix { });

  icon = "Colloid-teal-nord-dark";
  iconPkg = pkgs.colloid-icon-theme.override {
    schemeVariants = [ "nord" ];
    colorVariants = [ "teal" ];
  };

  customFont = "Maple Mono";
in {
  # GTK Look and Feel
  gtk = {
    enable = true;
    theme = {
      name = gtkTheme;
      package = gtkPkg;
    };
    cursorTheme = {
      name = cursor;
      package = cursorPkg;
    };
    font = {
      name = customFont;
      size = 12;
    };
    iconTheme = {
      name = icon;
      package = iconPkg;
    };
  };

  # Qt Style
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${qtStyle}
    '';

    "Kvantum/${qtStyle}".source = "${qtPkg}/share/Kvantum/${qtStyle}";
  };

  # Hyprland Managed Cursor
  home.packages = with pkgs; [ hyprcursor ];
  wayland.windowManager.hyprland.extraConfig = ''
    env = HYPRCURSOR_THEME,${cursor}
    env = HYPRCURSOR_SIZE,48
    env = XCURSOR_THEME,${cursor}
    env = XCURSOR_SIZE,24
    env = ICON_THEME,${icon}
  '';

  home.activation = {
    fixFlatpakThemes = ''
      run rm -rf /home/ckgxrg/.icons/*
      run rm -rf /home/ckgxrg/.themes/*
      run ln -sfT ${iconPkg}/share/icons/${icon} /home/ckgxrg/.icons/${icon}
      run ln -sfT ${cursorPkg}/share/icons/${cursor} /home/ckgxrg/.icons/${cursor}
      run ln -sfT ${gtkPkg}/share/themes/${gtkTheme} /home/ckgxrg/.themes/${gtkTheme}
    '';
  };

  # Mako vs Alien paths
  services.mako.iconPath = "/etc/profiles/per-user/ckgxrg/share/icons/${icon}";

  # Then make them availiable to Flatpaks
  services.flatpak.overrides = {
    global = {
      # Force Wayland
      Context.sockets = [ "wayland" "!x11" "fallback-x11" ];
      # Make files accessible to flatpaks
      Context.filesystems = [
        "/home/ckgxrg/.themes:ro"
        "/home/ckgxrg/.icons:ro"
        "${gtkPkg}/share/themes:ro"
        "${iconPkg}/share/icons:ro"
        "${cursorPkg}/share/icons:ro"
        "xdg-config/Kvantum:ro"
      ];
      # Set themes
      Environment = {
        "GTK_THEME" = gtkTheme;
        "ICON_THEME" = icon;
        "QT_STYLE_OVERRIDE" = "kvantum";
        "HYPRCURSOR_THEME" = cursor;
        "HYPRCURSOR_SIZE" = "48";
        "XCURSOR_PATH" = "${cursorPkg}/share/icons";
        "XCURSOR_THEME" = cursor;
        "XCURSOR_SIZE" = "24";
      };
    };
  };
}
