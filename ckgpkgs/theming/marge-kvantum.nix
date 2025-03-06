{
  fetchFromGitLab,
  stdenvNoCC,
  jdupes,
}:
# Marge Kvantum theme
stdenvNoCC.mkDerivation {
  pname = "marge-kvantum-theme";
  version = "c580d083";

  dontBuild = true;
  nativeBuildInputs = [ jdupes ];

  src = fetchFromGitLab {
    owner = "jomada";
    repo = "marge";
    rev = "c580d08371773682be434bf8488d51c83df96211";
    hash = "sha256-fiqvkp++t8Vv/L1ggdFciKkfGmjelbH6o0qG3MeZycw=";
  };
  installPhase = ''
    mkdir -p $out/share
    mv * $out/share
    mv $out/share/kvantum $out/share/Kvantum
    jdupes --quiet --link-soft --recurse $out/share
  '';
}
