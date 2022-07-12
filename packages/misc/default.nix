{ config, lib, pkgs, ... }:

{
  imports = [
    ./browsers
    ./communication
    ./gestures
  ];
}
