{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.users.sylvie.nixos;

in {
  options.users.sylvie.nixos = {
    enable = mkEnableOption "NixOS specific config";
  };

  config = mkIf cfg.enable {
    users.users.sylvie = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
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
      imports = [];
    };
  };
}
