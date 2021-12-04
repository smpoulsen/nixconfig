{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sylvie";
  home.homeDirectory = "/home/sylvie";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  programs.fish.enable = true;
  programs.emacs.enable = true;

  home.packages = [
    pkgs.tmux
    pkgs.stow
    pkgs.nox
    pkgs._1password-gui
  ];

  imports = [
    ./dotfiles/git.nix
    ./dotfiles/gpg/gpg.nix
    ./dotfiles/gpg/gpg-agent.nix
  ];
}
