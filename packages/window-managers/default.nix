{ config, lib, pkgs, ... }:

{
  imports = [
    ./gnome
    ./i3
    ./polybar
  ];
}
