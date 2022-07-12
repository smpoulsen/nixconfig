{ pkgs, config, lib, options, ... }:
with lib;

let
  chromiumCfg = config.sylvie.packages.misc.browsers.chromium;

in {
  options.sylvie.packages.misc.browsers.chromium = {
    enable = mkEnableOption "Enable Chromium";
  };

  config = mkIf (chromiumCfg.enable or slackCfg.enable) {
    home.packages = (if chromiumCfg.enable then [pkgs.chromium] else []);
  };
}
