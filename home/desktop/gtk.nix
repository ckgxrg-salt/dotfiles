{ config, ... }: {
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
    cursorTheme = {
      inherit (config.theme.cursor) package name size;
    };
  };
}
