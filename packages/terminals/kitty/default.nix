{ lib, pkgs, config, ... }:
with lib;

let
  cfg = config.sylvie.packages.terminals.kitty;
  kitty_config = builtins.readFile ./config/kitty.conf;

in {
  options.sylvie.packages.terminals.kitty = {
    enable = mkEnableOption "kitty config";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.kitty ];

    xdg = {
      enable = true;
      configFile = {
        "kitty/kitty.conf"= {
          text = "${kitty_config}";
          onChange = "pkill -SIGUSR1 -x kitty";
        };
      };
    };
  };
}
