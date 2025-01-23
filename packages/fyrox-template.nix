{
  rustPlatform,
  fetchCrate,
}:
rustPlatform.buildRustPackage rec {
  pname = "fyrox-template";
  version = "0.11.0";
  
  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-ngPZSxAohuOVW9BpG8awd5Toaz23gnFTifV/PzYNtRc=";
  };
  
  cargoHash = "sha256-5wIDtBDhvW77Qi1SUk+HRICM8TOYpWKN9KqMQav8qGc=";
}
