{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.dockerDesktop;

  packages = self;

in {
  options.modules.dockerDesktop = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
      Installs Docker Desktop
      '';
    };
  };

  config = mkIf cfg.enable {
    modules.dockerDesktop =  pkgs.callPackage ./docker.nix { };
  };
}
