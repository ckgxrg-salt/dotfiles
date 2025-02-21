{
  fetchFromGitHub,
  rustPlatform,
  lib,
}:
# LxWEngD
rustPlatform.buildRustPackage {
  pname = "lxwengd";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "ckgxrg-salt";
    repo = "LxWEngD";
    rev = "0b41a9e86d3d56119385e5f46bf9a53da7e1820a";
    hash = "sha256-qQDOZJPHpc58ws4YARrAV11xYrSdNMY9hbzj5MVlXQg=";
  };
  cargoHash = "sha256-21yr1jWCjB8szwEHRfxXAXdGlEKY/IVZJbL4suPvIIE=";
  useFetchCargoVendor = true;

  meta = {
    description = "A daemon that adds playlists to linux-wallpaperengine";
    homepage = "https://github.com/ckgxrg-salt/LxWEngD";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.ckgxrg ];
  };
}
