{ config, osConfig, ... }: {
  theme.matugen.templates = {
    gtk3 = {
      input_path = ../theme/templates/gtk.css;
      output_path = "${config.xdg.configHome}/gtk-3.0/gtk.css";
    };
    gtk4 = {
      input_path = ../theme/templates/gtk.css;
      output_path = "${config.xdg.configHome}/gtk-4.0/gtk.css";
    };

  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Adwaita";
    };
    font = {
      inherit (osConfig.theme.fonts) name;
      size = osConfig.theme.fonts.sizes.applications;
    };
    cursorTheme = {
      inherit (osConfig.theme.cursor) package name size;
    };
  };
}
