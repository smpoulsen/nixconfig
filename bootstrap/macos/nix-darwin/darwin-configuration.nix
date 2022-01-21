{ config, pkgs, lib, ... }:

{
  services.nix-daemon.enable = true;
  nix.useDaemon = true;
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/code/nixconfig/machines/macos/rhodenite/darwin-configuration.nix";
}
