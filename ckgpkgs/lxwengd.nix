{
  fetchFromGitHub,
  rustPlatform,
  lib,
}:
# LxWEngD
rustPlatform.buildRustPackage {
  pname = "lxwengd";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "ckgxrg-salt";
    repo = "LxWEngD";
    rev = "581fe1ec9adf5b76f502c52c8959fe0760cc7f6d";
    hash = "sha256-Yz7JF84D0zFVCrTgMvVxpu1Ij6qlC6jADx4JD4JKcYw=";
  };
  cargoHash = "sha256-xjvungzXEoc46RTZS2QH3sMOX5CJdG1fIpAjWKgzmIE=";
  useFetchCargoVendor = true;

  meta = {
    description = "A daemon that adds playlists to linux-wallpaperengine";
    homepage = "https://github.com/ckgxrg-salt/LxWEngD";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.ckgxrg ];
  };
}
