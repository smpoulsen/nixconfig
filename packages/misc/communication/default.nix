{ pkgs, config, lib, options, ... }:
with lib;

let
  teamsCfg = config.sylvie.packages.communication.teams;
  slackCfg = config.sylvie.packages.communication.slack;

  myTeams = (pkgs.teams.overrideAttrs (attrs: {
      forceShare = attrs.postFixup.forceShare or [] ++ ["bin"];
  }));
  mySlack = (pkgs.slack.overrideAttrs (attrs: {
      forceShare = attrs.postFixup.forceShare or [] ++ ["bin/slack"];
  }));

in {
  options.sylvie.packages.communication.teams = {
    enable = mkEnableOption "Enable MS Teams";
  };

  options.sylvie.packages.communication.slack = {
    enable = mkEnableOption "Enable Slack";
  };

  config = mkIf (teamsCfg.enable or slackCfg.enable) {
    home.packages = (if teamsCfg.enable then [pkgs.teams] else [])
                    ++ (if slackCfg.enable then [pkgs.slack] else []);
  };
}
