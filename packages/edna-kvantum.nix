{
  fetchFromGitLab,
  stdenv,
  pkgs,
}:
# The Edna Kvantum theme
stdenv.mkDerivation {
  pname = "edna-kvantum-theme";
  version = "22e713f2";
  dontBuild = true;
  nativeBuildInputs = [ pkgs.jdupes ];
  src = fetchFromGitLab {
    owner = "jomada";
    repo = "edna";
    rev = "22e713f2ff1840cbee87654687a8e1a31c31e6f9";
    hash = "sha256-xsA9wcdJXJ+u3udJQ2rLXssYeixJcHjerC42BJpfzus=";
  };
  installPhase = ''
    mkdir -p $out/share
    mv * $out/share
    jdupes --quiet --link-soft --recurse $out/share
  '';
}
