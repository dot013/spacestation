{
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule rec {
  name = "Anubis";
  pname = "anubis";
  version = "1.15.2";

  src = fetchFromGitHub {
    owner = "TecharoHQ";
    repo = "anubis";
    rev = "35e0a8179a70678708ceb90c9a285940f99b9774";
    hash = "sha256-5OqpmuRTrM+hseIhR2sTb+K01Co6X+Rhb6mN+U54NAI=";
  };

  vendorHash = "sha256-Rcra5cu7zxGm2LhL2x9Kd3j/uQaEb8OOh/j5Rhh8S1k=";

  doCheck = false;

  meta = {
    mainProgram = "anubis";
  };
}
