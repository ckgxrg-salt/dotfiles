{ ... }:
{
  imports = [ ../../../shared/nixvim ];

  # Neovim themes
  programs.nixvim = {
    colorscheme = "rose-pine";
    plugins.lualine.settings.options.theme = "nightfly";
    colorschemes.rose-pine = {
      enable = true;
      settings = {
        variant = "moon";
      };
    };
  };

  # GUI
  programs.neovide = {
    enable = true;
    settings = {
      font = {
        size = 16;
        normal = {
          family = "Maple Mono SC NF";
          style = "Regular";
        };
        bold = {
          family = "Maple Mono SC NF";
          style = "Bold";
        };
        italic = {
          family = "Maple Mono SC NF";
          style = "Italic";
        };
        bold_italic = {
          family = "Maple Mono SC NF";
          style = "BoldItalic";
        };
      };
    };
  };
}
