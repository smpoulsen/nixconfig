{ config, lib, pkgs, ... }:

let
  isNixOS = config.users.sylvie.system == "nixos";

in {
  imports = [
    # Modules
    ./modules
    # Services
    services/i3
  ];

  sylvie.packages = {
    emacs.enable = true;
    fish.enable = true;
    git.enable = true;
    neovim.enable = true;
    tmux.enable = true;
    vim.enable = false;

    # NixOS specific defaults
    alacritty.enable = if isNixOS then true else false;
    gpg.enable = if isNixOS then true else false;
    polybar.enable = if isNixOS then true else false;
  };

  sylvie.services = {
    i3.enable = if isNixOS then true else false;
  };
}
