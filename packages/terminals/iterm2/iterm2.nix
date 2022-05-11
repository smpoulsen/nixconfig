{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "iterm2";
  version = "3_4_15";
  nativeBuildInputs = [ unzip ];
  buildInputs = [ unzip ];
  src = fetchurl {
    url = "https://iterm2.com/downloads/stable/iTerm2-${version}.zip";
    sha256 = "0y0vhxwn1cl0y1gjm5fad5zndb4v448mqcksbmmskpgg73h4wn9j";
  };

  phases = ["installPhase" "patchPhase"];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/iTerm
  '';

  postInstall = ''
    cp -rs $out/bin/iTerm $HOME/Applications/iTerm
  '';
}
