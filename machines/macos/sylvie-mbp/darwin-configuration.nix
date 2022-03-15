{ config, pkgs, lib, ... }:

{
  imports = [
    ../../common
  ];

  users.users.sylvie.home = /Users/sylvie;

  environment.systemPackages = [
      pkgs.openvpn
    ];

  nix.useDaemon = true;
  services.nix-daemon.enable = true;
  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
