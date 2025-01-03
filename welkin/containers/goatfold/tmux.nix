{ ... }:
# Minecraft servers are not really daemons, so we need to interact with them.
{
  programs.tmux = {
    enable = true;
    secureSocket = true;
    clock24 = true;
  };
}
