{
  ckgs,
  ...
}:
# Daywatch terminal overrides
{
  ckgxrg = {
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
        };
        font = {
          normal = {
            family = "Maple Mono SC NF";
            style = "Regular";
          };
          bold.style = "Bold";
          italic.style = "Italic";
          bold_italic.style = "BoldItalic";
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
        $env.config = {
          show_banner: false
          error_style: "fancy"
          table: {
            mode: reinforced
            index_mode: auto
          }
          completions: {
            case_sensitive: false
            algorithm: "fuzzy"
          }
          filesize: {
            unit: metric
          }
        }

        $env.MANPAGER = "nvim +Man!";
        $env.LS_COLORS = (vivid generate catppuccin-mocha | str trim)

        def ciallo [] { fortune | cowsay | lolcat }

        alias deploy = nh os switch --ask
        alias purge = nh clean all --ask

        alias dotfiles = cd ~/.config/nixos/system
        alias welkin = cd ~/.config/nixos/welkin
      '';
    };
  };
}
