{
  ckgs,
  ...
}:
# Daywarden terminal overrides
{
  ckgxrg = {
    alacritty = {
      enable = true;
      theme = ckgs.alacritty-themes.override {
        theme = "tokyo-night-storm";
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
        theme = "tokyo-storm";
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
            metric: true
          }
        }

        $env.MANPAGER = "nvim +Man!";
        $env.LS_COLORS = (vivid generate solarized-dark | str trim)

        def ciallo [] { fortune | cowsay | lolcat }

        def dotfiles [] { cd ~/.config/nixos/system; nix develop }
        def ckgpkgs [] { cd ~/.config/nixos/ckgpkgs; nix develop }

        def dev [ name ] { cd $"~/Documents/Codes/($name)"; nix develop }

        alias deploy = nh os switch --ask
        alias purge = nh clean all --ask
      '';
    };
  };
}
