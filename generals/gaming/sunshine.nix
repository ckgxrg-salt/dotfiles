{ ... }:
# Sunshine streaming tool
{
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = false;
    settings = {
      sunshine_name = "Radilopa";
    };
  };
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
  services.udev.extraRules = ''
    Sunshine
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';
}
