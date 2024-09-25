{
  ckgxrg,
  pkgs,
  ...
}:
# Daywarden terminal overrides
{
  imports = [
    ../../../modules/terminal/alacritty.nix
    ../../../modules/terminal/nushell.nix
  ];

  ckgxrg = {
    alacritty = {
      enable = true;
      theme = (pkgs.callPackage ../../../packages/alacritty-themes.nix { theme = "marine_dark"; });
      settings = {
        window = {
          opacity = 0.9;
          blur = true;
          decorations_theme_variant = "Dark";
        };
      };
    };
    nushell = {
      enable = true;
      theme = (pkgs.callPackage ../../../packages/nu-scripts.nix { theme = "cobalt-neon"; });
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
        def clear [] { ^clear; ciallo }

        alias true-clear = ^clear
        alias deploy = nh os switch --ask
        alias purge = nh clean all --ask

        ciallo
      '';
    };
  };
}
