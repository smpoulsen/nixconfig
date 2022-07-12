{ pkgs, config, lib, options, ... }:
with lib;

let
  teamsCfg = config.sylvie.packages.misc.communication.teams;
  slackCfg = config.sylvie.packages.misc.communication.slack;
  thunderbirdCfg = config.sylvie.packages.misc.communication.slack;
  obsCfg = config.sylvie.packages.misc.communication.obs;

in {
  options.sylvie.packages.misc.communication.teams = {
    enable = mkEnableOption "Enable MS Teams";
  };

  options.sylvie.packages.misc.communication.slack = {
    enable = mkEnableOption "Enable Slack";
  };

  options.sylvie.packages.misc.communication.thunderbird = {
    enable = mkEnableOption "Enable Thunderbird";
  };

  options.sylvie.packages.misc.communication.obs = {
    enable = mkEnableOption "Enable OBS Studio";
  };

  config = mkIf (teamsCfg.enable or slackCfg.enable) {
    home.packages = (if teamsCfg.enable then [pkgs.teams] else [])
                    ++ (if slackCfg.enable then [pkgs.slack] else [])
                    ++ (if thunderbirdCfg.enable then [pkgs.thunderbird] else [])
                    ++ (if obsCfg.enable then [pkgs.obs-studio] else []);
  };
}
