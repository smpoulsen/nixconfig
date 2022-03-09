{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "docker-desktop";
  version = "3_4_15";
  src = fetchurl {
    url = "https://desktop.docker.com/mac/main/amd64/Docker.dmg";
    sha256 = "1bm3kgapr905blkqj9b1i1a9r4ilg740kx3h64ljnisgqlgf4rgs";
  };

  phases = ["installPhase"];

  installPhase = ''
    VOLUME=`/usr/bin/hdiutil attach $src | grep Volumes | awk '{print $3}'`
    cp -rf $VOLUME/*.app $out
    /usr/bin/hdiutil detach $VOLUME
  '';
}
