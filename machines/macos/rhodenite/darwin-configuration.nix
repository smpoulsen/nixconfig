{ config, pkgs, lib, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ../../common
    ../../../users/sylvie/macos/sylvie-mbp.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
      pkgs.openvpn
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/code/nixconfig/machines/macos/rhodenite/darwin-configuration.nix";

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nix.useDaemon = true;
  services.nix-daemon.enable = true;
  # Auto upgrade nix package and the daemon service.
  # nix.package = pkgs.nix;


  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
