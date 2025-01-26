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
    rev = "e245718d308b107997b34e408df72acba395590a";
    hash = "sha256-QB8suiHQa/fO4Bu2XJMCiIRseLKL4YBkFwl0zI0XkAo=";
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
