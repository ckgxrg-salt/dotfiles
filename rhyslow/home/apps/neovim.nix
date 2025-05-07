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
}
