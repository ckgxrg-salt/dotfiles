{
  config,
  osConfig,
  pkgs,
  ...
}:
{
  theme.matugen.templates.gtk = {
    input_path = ../theme/templates/gtk.css;
    output_path = "${config.xdg.configHome}/gtk-4.0/matugen.css";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    gtk4.theme = config.gtk.theme;
    gtk3.extraCss = ''@import url("file://${config.xdg.configHome}/gtk-4.0/matugen.css");'';
    gtk4.extraCss = ''@import url("file://${config.xdg.configHome}/gtk-4.0/matugen.css");'';
    iconTheme.name = osConfig.theme.icons.name;
    font = {
      inherit (osConfig.theme.fonts) name;
      size = osConfig.theme.fonts.sizes.applications;
    };
    cursorTheme = {
      inherit (osConfig.theme.cursor) package name size;
    };
  };
}
