{ pkgs, config, lib, options, ... }:
with lib;

let
  rubyCfg = config.sylvie.packages.languages.ruby;

in {
  options.sylvie.packages.languages.ruby = {
    enable = mkEnableOption "Enable Ruby";

    version = mkOption {
      type = types.str;
      default = "ruby_3_1";
    };
  };

  config = mkIf rubyCfg.enable {
    home.packages = [
      pkgs.bundix
      pkgs.${rubyCfg.version}
    ];
  };
}
