{ config, lib, pkgs, ... }: {

  users.users.sylvie = {
    shell = pkgs.fish;
  };

  home-manager.users.sylvie = { config, pkgs, ... }: {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
      username = "sylvie";

      # Env Vars
      sessionVariables = {
        BROWSER = "firefox";
        EDITOR = "vim";
      };

      stateVersion = "21.11";
    };

    # Let Home Manager install and manage itself.
    # programs.home-manager.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };


    programs.fish.enable = true;

    home.file = {
      qmk = {
        source = config/qmk;
        recursive = true;
        target = ".config/qmk";
      };
    };

    home.packages = with pkgs; [
      # Apps

      # Dev
      nox
      jq
      tmux

      # Fonts

      # Sys tools
      exa
      fd
      fish
      fishPlugins.foreign-env
      fzf
      htop
      ripgrep
      stow
    ];
  };
}
