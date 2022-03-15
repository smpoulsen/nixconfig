{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "amethyst";
  version = "v0.15.5";
  nativeBuildInputs = [ unzip ];
  buildInputs = [ unzip ];
  src = fetchurl {
    url = "https://github.com/ianyh/Amethyst/releases/download/${version}/Amethyst.zip";
    sha256 = "10z6dj8cbvq3zrj3582kxwj52a6d39s6qr8cgrpsq4zz6sf9xlx3";
  };

  phases = ["installPhase" "patchPhase"];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/Amethyst
  '';

  postInstall = ''
    cp -rs $out/bin/Amethyst $HOME/Applications/Amethyst
  '';
}
