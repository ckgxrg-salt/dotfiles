{
  fetchFromGitHub,
  stdenvNoCC,
  lib,
  theme ? "default-dark",
}:
# Themes for nushell
stdenvNoCC.mkDerivation {
  pname = "nu-scripts";
  version = "f74b2aa";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "nushell";
    repo = "nu_scripts";
    rev = "f74b2aa7770a4c78ac7cb13fe2015f23ed9c597c";
    hash = "sha256-P0cZ2OflWpiB3TB6VUU6ne9WQrSV3Dwq8wYeysAdMNs=";
  };
  installPhase = ''
    mkdir -p $out
    cp themes/nu-themes/${theme}.nu $out/theme.nu
  '';
  meta = with lib; {
    description = "A place to share Nushell scripts with each other ";
    longDescription = ''
      This is a place to share Nushell scripts with each other. 
      If you'd like to share your scripts, fork this repository, 
      and create a PR that adds it to the repo.
    '';
    homepage = "https://github.com/nushell/nu_scripts";
    license = licenses.mit;
  };
}
