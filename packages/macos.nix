{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
    # Modules
    modules/emacs/macos.nix

    # Services
  ];
}
