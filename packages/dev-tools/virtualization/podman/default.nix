{ pkgs, config, lib, options, ... }:
with lib;

let
  podmanCfg = config.sylvie.packages.dev-tools.virtualization.podman;

in {
  imports = [];

  options.sylvie.packages.dev-tools.virtualization.podman = {
    enable = mkEnableOption "Enable podman";

    compose = mkOption {
      type = types.bool;
      default = true;
      description = "Enable docker-compose";
    };
  };

  config = mkIf podmanCfg.enable {
    home.packages = [
      pkgs.podman
    ] ++ (
      if podmanCfg.compose
      then [ pkgs.docker-compose ]
      else []
    );
  };
}
