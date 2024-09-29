{
  ckgxrg,
  ckgs,
  pkgs,
  ...
}:
# Daywarden terminal overrides
{
  ckgxrg = {
    alacritty = {
      enable = true;
      theme = ckgs.alacritty-themes.override {
        theme = "everforest_dark";
      };
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
        }

        $env.MANPAGER = "nvim +Man!";
        $env.LS_COLORS = (vivid generate solarized-dark | str trim)

        def ciallo [] { fortune | cowsay | lolcat }
        def clear [] { ^clear; ciallo }

        alias true-clear = ^clear
        alias syscfg = cd ~/.config/nixos/system
        alias syspkg = cd ~/.config/nixos/ckgpkgs
        alias deploy = nh os switch --ask
        alias purge = nh clean all --ask

        ciallo
      '';
    };
  };
}
