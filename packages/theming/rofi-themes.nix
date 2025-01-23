{
  fetchFromGitHub,
  stdenvNoCC,
  lib,
  type ? "type-1",
  style ? "style-1"
}:
# adi1090x's rofi theme collection
stdenvNoCC.mkDerivation {
  pname = "rofi-themes";
  version = "f3835e7";
  dontBuild = true;
  
  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "rofi";
    rev = "f3835e7f728bf6d94fb3c2c683c6754e6ccd202e";
    hash = "sha256-xlcI9K6cXJetaphkMW5mVWDshqcXeTtxAAwtOK5fF6s=";
  };

  installPhase = ''
    mkdir -p $out/config/rofi
    cp -rf files/* $out/config/rofi
    substituteInPlace `find $out -type f -not -name "*.png" -not -name "*.jpg" -not -name "*.jpeg"` --replace-quiet \$HOME/.config $out/config
    substituteInPlace `find $out -type f -not -name "*.png" -not -name "*.jpg" -not -name "*.jpeg"` --replace-warn \~/.config $out/config
  '';

  meta = with lib; {
    description = "A huge collection of Rofi based custom Applets, Launchers & Powermenus.";
    homepage = "https://github.com/adi1090x/rofi";
    maintainers = with maintainers; [ ckgxrg ];
    license = licenses.gpl3;
  };
}
