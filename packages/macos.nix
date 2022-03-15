{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix

    # Modules
    modules/emacs/macos.nix
    modules/gpg/macos.nix
    # modules/amethyst
    # modules/docker

    # Services
    # services/macos.nix
  ];
}
