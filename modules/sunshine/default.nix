{pkgs, ...}:
{
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = true;
    settings = {
      sunshine_name = "Radilopa";
    };
  };
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
  users.users.ckgxrg.extraGroups = [ "input" ];
  services.udev.extraRules = ''
    Sunshine
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';
  networking.wg-quick.interfaces = {
    iof.configFile = "/etc/wireguard/iof.conf";
  };
}