{ config, lib, pkgs, ... }: {
  imports = [
    ../common
  ];

  home-manager.users.sylvie = { config, pkgs, ... }: {
    imports = [
      ../../../packages/macos.nix
    ];

    home = {
      # Env Vars
      sessionVariables = {
        TERMINAL = "iTerm2";
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
