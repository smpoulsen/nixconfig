{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix

    # Modules
    modules/emacs/macos.nix
    modules/gpg/macos.nix
    # modules/docker

    # Services
  ];
}
