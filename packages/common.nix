{ config, lib, pkgs, ... }:

{
  imports = [
    # Modules
    modules/emacs
    modules/git
    modules/neovim
    modules/tmux
    modules/vim
    modules/fish

    # Services
  ];
}
