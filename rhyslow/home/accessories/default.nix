{ ... }:
# Extra desktop programs
{
  imports = [
    ./daemons.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./mako.nix
    ./scripts.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
