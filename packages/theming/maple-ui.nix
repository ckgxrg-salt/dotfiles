{
  fetchurl,
  stdenvNoCC,
  lib,
}:
# Maple UI font
let
  regular = fetchurl {
    url = "https://gitee.com/subframe7536/Maple/releases/download/v5.1/Maple%20UI.ttf";
    name = "Maple UI.ttf";
    hash = "sha256-rUAEjONhJGub49VwJcK5llhzUx0aa81wSKK3CVtGN0g=";
  };
  bold = fetchurl {
    url = "https://gitee.com/subframe7536/Maple/releases/download/v5.1/Maple%20UI%20Bold.ttf";
    name = "Maple UI Bold.ttf";
    hash = "sha256-iB8Fyb2t3IZKgkzpfkbSR+ssaL6fxJsbPqZcns/y6KQ=";
  };

in
stdenvNoCC.mkDerivation {
  pname = "maple-ui";
  version = "5.1";

  srcs = [
    regular
    bold
  ];
  sourceRoot = ".";
  dontUnpack = true;

  installPhase = ''
    mkdir -p  $out/share/fonts/truetype
    cp ${regular} $out/share/fonts/truetype/Maple\ UI.ttf
    cp ${bold} $out/share/fonts/truetype/Maple\ UI\ Bold.ttf
  '';

  meta = with lib; {
    homepage = "https://github.com/subframe7536/Maple-font";
    description = ''
      Open source font with round corner and ligatures for IDE and command line
    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ ckgxrg ];
  };
}
