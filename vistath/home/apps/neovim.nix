{ pkgs, ... }:
{
  imports = [ ../../../shared/nixvim ];

  # Neovim themes
  programs.nixvim = {
    colorscheme = "everforest";
    plugins.lualine.settings.options.theme = "everforest";
    extraPlugins = [ pkgs.vimPlugins.everforest ];
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
