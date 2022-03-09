{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.packages.iterm2;

in {
  options = {
    configDirectory = {
      enable = mkOption {
        default = "${config.xdg.configHome}/iterm";
        description = ''
          Directory containing iTerm2 configuration
        '';
      };
    };
  };

  config = mkIf cfg.enable {

  }
}
