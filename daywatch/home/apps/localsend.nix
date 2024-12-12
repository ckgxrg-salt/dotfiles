{ pkgs, ... }:
# It's here just because of the firewall
{
  # Localsend itself
  home.packages = with pkgs; [ localsend ];

  # Open firewall
  osConfig.networking.firewall = {
    allowedTCPPorts = [ 53317 ];
  };
}
