{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
    # Modules
    modules/alacritty
    modules/gpg
    modules/polybar

    # Services
    services/i3
  ];
}
