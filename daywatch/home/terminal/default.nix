{ ckgs, ... }:
# Daywatch terminal overrides
{
  terminal = {
    alacritty = {
      enable = true;
      theme = ckgs.alacritty-themes.override {
        theme = "everforest_dark";
      };
      settings = {
        window = {
          opacity = 1.0;
          blur = true;
          decorations_theme_variant = "Dark";
          padding = {
            x = 12;
            y = 12;
          };
        };
        font = {
          size = 16;
        };
      };
    };
    nushell = {
      enable = true;
      theme = ckgs.nu-scripts.override {
        theme = "everforest";
      };
      settings = ''
        $env.LS_COLORS = (vivid generate catppuccin-mocha | str trim)
      '';
    };
  };
}
