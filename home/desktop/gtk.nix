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
    gtk3 = {
      theme.name = "Adwaita";
      iconTheme.name = osConfig.theme.icons.name;
    };
    gtk4 = {
      theme.name = "Adwaita";
      iconTheme.name = osConfig.theme.icons.name;
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
