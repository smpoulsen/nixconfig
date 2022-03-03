{ config, lib, pkgs, ... }: {
  imports = [
    ../common.nix
  ];
  users.users.sylvie = {
    isNormalUser = true;
    extraGroups = [ "wheel"
                    "docker"
                  ];
  };

  security.sudo.extraRules = [
    { users = [ "sylvie" ];
      commands = [
          { command = "ALL";
            options = [ "NOPASSWD" ];
          }
      ];
    }
  ];

  home-manager.users.sylvie = { config, pkgs, ... }: {
    imports = [
      ../../../packages/nixos.nix
    ];

    # Fonts
    fonts.fontconfig.enable = true;

    home = {
      homeDirectory = "/home/sylvie";

      # Env Vars
      sessionVariables = {
        TERMINAL = "alacritty";
      };
    };

    home.packages = with pkgs; [
      # Apps
      _1password-gui

      # Fonts
      cascadia-code

      # Sys tools
      gnumake
    ];
  };
}
