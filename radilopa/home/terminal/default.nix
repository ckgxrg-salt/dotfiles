{
  ckgs,
  ...
}:
# Radilopa terminal overrides
{
  ckgxrg = {
    alacritty = {
      enable = true;
      theme = ckgs.alacritty-themes.override {
        theme = "rose_pine_moon";
      };
      settings = {
        window = {
          opacity = 0.9;
          blur = true;
          decorations_theme_variant = "Dark";
        };
        font = {
          size = 18;
        };
      };
    };
    nushell = {
      enable = true;
      theme = ckgs.nu-scripts.override {
        theme = "rose-pine-moon";
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
        $env.LS_COLORS = (vivid generate rose-pine-moon | str trim)

        def ciallo [] { fortune | cowsay | lolcat }

        alias deploy = nh os switch --ask
        alias purge = nh clean all --ask

        alias dotfiles = cd ~/.config/nixos/system
        alias welkin = cd ~/.config/nixos/welkin
      '';
    };
  };
}
