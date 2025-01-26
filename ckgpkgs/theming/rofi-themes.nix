{
  fetchFromGitHub,
  stdenvNoCC,
  lib,
}:
# adi1090x's rofi theme collection
stdenvNoCC.mkDerivation {
  pname = "rofi-themes";
  version = "f3835e7";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "rofi";
    rev = "2e0efe5054ac7eb502a585dd6b3575a65b80ce72";
    hash = "sha256-TVZ7oTdgZ6d9JaGGa6kVkK7FMjNeuhVTPNj2d7zRWzM=";
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
