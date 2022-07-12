{ pkgs, config, lib, options, ... }:
with lib;

let
  dockerCfg = config.sylvie.packages.dev-tools.virtualization.docker;

in {
  imports = [];

  options.sylvie.packages.dev-tools.virtualization.docker = {
    enable = mkEnableOption "Enable docker";

    compose = mkOption {
      type = types.bool;
      default = true;
      description = "Enable docker-compose";
    };
  };

  config = mkIf dockerCfg.enable {
    home.packages = [
      pkgs.docker
    ] ++ (
      if dockerCfg.compose
      then [ pkgs.docker-compose ]
      else []
    );
  };
}
