{ pkgs, config, lib, options, ... }:
with lib;

let
  cfg = config.sylvie.packages.dev-tools.virtualization.docker-compose;

in {
  imports = [
    ./docker
    ./podman
  ];

  options.sylvie.packages.dev-tools.virtualization.docker-compose = {
    enable = mkEnableOption "Enable docker-compose";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.docker-compose
    ];
  };
}
