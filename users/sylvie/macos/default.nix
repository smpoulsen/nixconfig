{ config, lib, pkgs, ... }: {
  imports = [
    ../common.nix
  ];

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
        _DARWIN_CONFIG = "$HOME/code/nixconfig/machines/macos/rhodenite/darwin-configuration.nix";
      };
    };

    home.packages = with pkgs; [
      # Apps

      # Dev

      # Fonts

      # Sys tools
      # iterm2
    ];
  };
}
