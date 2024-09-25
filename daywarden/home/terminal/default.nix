{
  ckgxrg,
  pkgs,
  ...
}:
# Daywarden terminal overrides
{
  imports = [
    ../../../modules/terminal/alacritty.nix
  ];

  ckgxrg.alacritty = {
    enable = true;
    theme = (pkgs.callPackage ../../../packages/alacritty-themes.nix { theme = "nordic"; });
    settings = {
      window = {
        opacity = 0.9;
        blur = true;
        decorations_theme_variant = "Dark";
      };
    };
  };
}
