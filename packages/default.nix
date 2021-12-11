{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules
    ./services
  ];
}
