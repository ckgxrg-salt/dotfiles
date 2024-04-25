{ stdenv, fetchFromGitHub }:
{
  sddm-theme-aerial = stdenv.mkDerivation rec {
    pname = "sddm-theme-aerial";
    version = "c8d2a8f";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/aerial-sddm-theme
    '';
    src = fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "ae6b7a4ad8d14da1cc3c3b712f1241b75dcfe836";
      hash = "sha256-pYhHgDiuyckKV2y325sZ5tuqVYLtKaWofKqsY7kgEpQ=";
    };
  };
}
