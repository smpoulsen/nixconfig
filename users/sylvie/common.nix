{ config, lib, pkgs, ... }: {

  users.users.sylvie = {
    # shell = pkgs.fish;
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

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    programs.fish.enable = true;

    home.packages = with pkgs; [
      # Apps

      # Dev
      cloc
      docker
      fswatch
      mkcert
      nox
      graphviz
      hyperfine
      ispell
      jq
      skopeo
      tmux
      vagrant
      yq

      # Fonts

      # Sys tools
      # autoconf
      # automake
      coreutils-full
      exa
      findutils
      fd
      fish
      fishPlugins.foreign-env
      fzf
      gnumake
      gnutls
      htop
      libfido2
      nmap
      openssh
      ripgrep
      stow
    ];
  };
}
