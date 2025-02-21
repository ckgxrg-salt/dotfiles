{ pkgs, ags }:
# All packages
with pkgs;
{
  alacritty-themes = callPackage ./theming/alacritty-themes.nix { };
  googledot-cursor = callPackage ./theming/googledot-cursor.nix { };
  nu-scripts = callPackage ./theming/nu-scripts.nix { };
  otis-gtk = callPackage ./theming/otis-gtk.nix { };
  vivid-icons = callPackage ./theming/vivid-icons.nix { };
  wvkbd-desktop = callPackage ./wvkbd-desktop.nix { };
  fyrox-template = callPackage ./fyrox-template.nix { };
  rofi-themes = callPackage ./theming/rofi-themes.nix { };
  maple-ui = callPackage ./theming/maple-ui.nix { };

  # qutebrowser themes
  qutebrowser-everforest = callPackage ./theming/qutebrowser/everforest.nix { };
  qutebrowser-rose-pine = callPackage ./theming/qutebrowser/rose-pine.nix { };
  qutebrowser-city-lights = callPackage ./theming/qutebrowser/city-lights.nix { };

  # Astal bundles
  daywatch-astal = import ./astal/daywatch { inherit ags pkgs; };

  # My personal packages
  lxwengd = callPackage ./lxwengd.nix { };
}
