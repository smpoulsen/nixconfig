{ config, lib, pkgs, ... }:

let
in {
  imports = [
    ../common.nix
    ./common/system
    ../../../packages/services/yabai
    #../../../packages/services/emacs/macos
  ];

  # modules.dockerDesktop.enable = true;
  # programs.amethyst.enable = true;

  home-manager.users.sylvie = { config, pkgs, ... }: {
    imports = [
      ../../../packages/macos.nix
    ];

    fonts.fontconfig.enable = false;

    home = {
      # Env Vars
      username = "sylvie";
      homeDirectory = /Users/sylvie;
      sessionVariables = {
        TERMINAL = "iTerm2";
      };

      file = {
        iterm = {
          source = ./config/iTerm;
          target = ".config/iterm2";
          recursive = true;
        };

        homebrew = {
          source = ./config/homebrew;
          target = ".config/homebrew";
          recursive = true;
        };
      };
    };

    home.packages = with pkgs; [
      # Apps

      # Dev
      postgresql_14

      # Fonts
      cascadia-code

      # Dev
      #dockerDesktop

      # Sys tools
      # iterm2
      # amethyst
      pinentry_mac
      skhd
      yabai
    ];
  };
}
