{ config, lib, pkgs, ... }: {
  imports = [
    ../common.nix
    # ../../../packages/modules/docker
  ];

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     dockerDesktop = prev.callPackage ../../../packages/modules/docker { inherit config; };
  #   }) ];

  # modules.dockerDesktop.enable = true;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  home-manager.users.sylvie = { config, pkgs, ... }: {
    imports = [
      ../../../packages/macos.nix
    ];


    fonts.fontconfig.enable = false;

    home = {
      # Env Vars
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

      # Fonts
      cascadia-code

      #dockerDesktop
      # Sys tools
      # iterm2
      pinentry_mac
    ];
  };
}
