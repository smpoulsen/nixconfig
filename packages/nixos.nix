{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules
    # Modules
    modules/emacs/nixos.nix
    modules/alacritty
    modules/gpg
    modules/polybar

    # Services
    services/i3
  ];
}
