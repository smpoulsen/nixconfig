{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.users.sylvie;
  isMac = pkgs.system == "x86_64-darwin";
  fontConfig = if isMac then false else true;
  homePackages = with pkgs; [
    # Apps
    _1password-gui

    # Dev
    cloc
    docker
    fswatch
    nox
    graphviz
    hyperfine
    ispell
    jq
    tmux
    vagrant
    yq

    # Fonts
    cascadia-code

    # Sys tools
    autoconf
    automake
    cmake
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
    yubikey-manager
  ];

in {
  imports = [
    #./nixos
  ];

  options.users.sylvie = {
    enable = mkEnableOption "Sylvie's user config";

    system = mkOption {
      type = types.enum [ "darwin" "nixos" "standalone" ];
      default = "nixos";
    };

    standalone = mkOption {
      type = types.bool;
      default = false;
    };

    username = mkOption {
      type = types.str;
      default = "sylvie";
    };

    homeDirectory = mkOption {
      type = types.str;
      default = if isMac
                then "/Users/${cfg.username}"
                else "/home/${cfg.username}";
    };

    terminal = mkOption {
      type = types.str;
      default = if isMac
                then "iterm2"
                else "alacritty";
    };

    editor = mkOption {
      type = types.str;
      default = "vim";
    };

    extraPackages = mkOption {
      type = types.listOf types.str;
      default = if isMac
                then [
                  pinentry_mac
                ]
                else [
                ];
    };
  };

  config = mkIf cfg.enable {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.fish.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home = {
      username = cfg.username;
      homeDirectory = cfg.homeDirectory;

      # Env Vars
      sessionVariables = {
        BROWSER = "firefox";
        EDITOR = cfg.editor;
        TERMINAL = cfg.terminal;
      };

      stateVersion = "22.05";
      packages = homePackages ++ cfg.extraPackages;
    };

    # Fonts
    fonts.fontconfig.enable = fontConfig;
  };
}
