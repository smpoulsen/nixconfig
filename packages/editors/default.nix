{ config, lib, pkgs, ... }:

{
  imports = [
    ./emacs
    ./neovim
    ./vim
  ];
}
