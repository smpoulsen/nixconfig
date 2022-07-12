{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.sylvie.packages.misc.gestures;

  conf_file = builtins.readFile ./config/libinput-gestures.conf;

in {
  options.sylvie.packages.misc.gestures = {
    enable = mkEnableOption "libinput-gestures config";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.libinput-gestures
      pkgs.wmctrl
    ];
    xdg = {
      enable = true;
      configFile = {
        "libinput-gestures.conf" = {
          text = "${conf_file}";
        };
      };
    };
  };
}
