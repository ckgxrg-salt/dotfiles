{ config, ...}:

{
  # Flatpak packages
  services.flatpak = {
    remotes = [{
      name = "flathub"; location = "https://mirror.sjtu.edu.cn/flathub";
    }];
    packages = [
      "com.moonlight_stream.Moonlight"
      "com.toolstack.Folio"
    ];
  };
}
