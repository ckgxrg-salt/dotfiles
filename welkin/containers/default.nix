{ ... }:
# Containers entrypoint
{
  containers = {
    # Common services
    "everpivot" = {
      autoStart = true;
      privateNetwork = true;
      hostBridge = "br0";
      localAddress = "192.168.50.101/24";
      localAddress6 = "2408:8215:123:16d0:e251:d8ff:95ca:72a1/64";
      config = import ./everpivot;
    };
    # Minecraft server
    "goatfold" = {
      autoStart = true;
      privateNetwork = true;
      hostBridge = "br0";
      localAddress = "192.168.50.103/24";
      localAddress6 = "2408:8215:123:16d0:e251:d8ff:95ca:72a1/64";
      config = import ./goatfold;
    };
  };
}
