{ config, pkgs, ... }:

{
  imports = [
    ../../packages
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "sylvie";
    homeDirectory = "/home/sylvie";

    # Env Vars
    sessionVariables = {
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
    stateVersion = "21.11";
  };

  xsession.enable = true;

  # Fonts
  fonts.fontconfig.enable = true;
  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  programs.fish.enable = true;
  programs.feh.enable = true;

  home.packages = with pkgs; [
    # Apps
    _1password-gui

    # Dev
    nox
    jq
    tmux

    # Desktop
    feh

    # Fonts
    cascadia-code

    # Sys tools
    exa
    fd
    fish
    fzf
    gnumake
    htop
    ripgrep
    stow
  ];
}
