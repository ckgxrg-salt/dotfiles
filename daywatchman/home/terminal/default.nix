{
  ckgs,
  ...
}:
# Daywatchman terminal overrides
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
          size = 14;
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

        def dotfiles [] { hyprctl --quiet --batch "dispatch focusmonitor DP-1; dispatch exec alacritty --working-directory ~/.config/nixos/system"; hyprctl --quiet dispatch focusmonitor eDP-1; nvim ~/.config/nixos/system }
        def ckgpkgs [] { hyprctl --quiet --batch "dispatch focusmonitor DP-1; dispatch exec alacritty --working-directory ~/.config/nixos/ckgpkgs"; hyprctl --quiet dispatch focusmonitor eDP-1; nvim ~/.config/nixos/ckgpkgs }

        def dev [ name ] { hyprctl --quiet --batch $"dispatch focusmonitor DP-1; dispatch exec alacritty --working-directory ~/Documents/Codes/($name) -e nix develop"; cd $"~/Documents/Codes/($name)"; hyprctl --quiet dispatch focusmonitor eDP-1; nix develop }

        alias deploy = nh os switch --ask
        alias purge = nh clean all --ask
      '';
    };
  };
}
