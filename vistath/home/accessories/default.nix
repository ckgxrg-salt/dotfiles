{ ... }:
# Extra programs for desktop environment
{
  imports = [
    ./daemons.nix
    ./gammastep.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./mako.nix
    ./scripts.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
