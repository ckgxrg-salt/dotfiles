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
    font.size = osConfig.theme.fonts.size;
    cursorTheme = {
      inherit (config.theme.cursor) package name size;
    };
  };
}
