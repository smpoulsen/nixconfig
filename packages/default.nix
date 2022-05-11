{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.sylvie.packages;
  isNixOS = config.users.sylvie.system == "nixos";

in {
  imports = [
    ./dev-tools
    ./editors
    ./misc
    ./shells
    ./terminals
    ./window-managers
  ];

  config = {
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
    };
  };
}
