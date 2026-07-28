{
  config,
  osConfig,
  ...
}:
{
  theme.matugen.templates = {
    qt-kvconfig = {
      input_path = ../theme/templates/kvantum.kvconfig;
      output_path = "${config.xdg.configHome}/Kvantum/Matugen/Matugen.kvconfig";
    };
    qt-svg = {
      input_path = ../theme/templates/kvantum.svg;
      output_path = "${config.xdg.configHome}/Kvantum/Matugen/Matugen.svg";
    };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "qtct";
    kvantum = {
      enable = true;
      settings = {
        General.theme = "Matugen";
      };
    };
    qt6ctSettings = {
      Appearance = {
        custom_palette = true;
        standard_dialogs = "xdgdesktopportal";
        style = config.qt.style.name;
        icon_theme = osConfig.theme.icons.name;
      };
      Fonts = {
        fixed = ''"${osConfig.theme.fonts.monospace},${toString osConfig.theme.fonts.sizes.applications}"'';
        general = ''"${osConfig.theme.fonts.name},${toString osConfig.theme.fonts.sizes.applications}"'';
      };
    };
    qt5ctSettings = config.qt.qt6ctSettings;
  };
}
