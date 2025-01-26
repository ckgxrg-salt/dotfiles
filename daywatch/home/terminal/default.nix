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
            metric: true
          }
          hooks: {
            pre_prompt: [{ ||
              if (which direnv | is-empty) {
                return
              }

              direnv export json | from json | default {} | load-env
              if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
                $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
              }
            }]
          }
        }

        $env.MANPAGER = "nvim +Man!";
        $env.LS_COLORS = (vivid generate catppuccin-mocha | str trim)

        def ciallo [] { fortune | cowsay | lolcat }

        def dotfiles [] { cd ~/.config/nixos/system; nix develop }
        def ckgpkgs [] { cd ~/.config/nixos/ckgpkgs; nix develop }
        def welkin [] { cd ~/.config/nixos/welkin; nix develop }

        def dev [ name ] { cd $"~/Documents/Codes/($name)"; nix develop }

        alias deploy = nh os switch --ask
        alias purge = nh clean all --ask
      '';
    };
  };
}
