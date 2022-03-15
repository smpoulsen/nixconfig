{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
    # Modules
    modules/emacs/nixos.nix
    modules/alacritty
    modules/gpg
    modules/polybar

    # Services
    services/i3
  ];
}
