{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.sylvie.packages;
  isNixOS = config.users.sylvie.system == "nixos";

in {
  imports = [
    ./dev-tools
    ./editors
    ./languages
    ./misc
    ./shells
    ./terminals
    ./window-managers
  ];

  config = {
    sylvie.packages = {
      editors = {
        emacs.enable = true;
        neovim.enable = true;
      vim.enable = false;
      };

      shells.fish.enable = true;

      dev-tools = {
        git.enable = true;
        tmux.enable = true;
      };
    };
  };
}
