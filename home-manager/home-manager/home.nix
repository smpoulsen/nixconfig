{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sylvie";
  home.homeDirectory = "/home/sylvie";

  # Env Vars
  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "vim";
    TERMINAL = "alacritty";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  xsession.enable = true;

  # Fonts
  fonts.fontconfig.enable = true;
  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  programs.fish.enable = true;
  programs.emacs.enable = true;
  programs.feh.enable = true;

  home.packages = with pkgs; [
    # Apps
    _1password-gui

    # Dev
    nox
    jq
    tmux

    # Desktop

    # Fonts
    cascadia-code

    # Sys tools
    exa
    htop
    ripgrep
    stow
  ];

  # TODO - stow relative links are making this very ugly.
  #        need to get them to be absolute
  imports = [
    ../../services
    ../../modules
  ];
}
