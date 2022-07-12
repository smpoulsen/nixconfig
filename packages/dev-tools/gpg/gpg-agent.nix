{ lib, pkgs, config, ... }:
with lib;

let
  cfg = config.sylvie.packages.dev-tools.gpgAgent;

in {
  options.sylvie.packages.dev-tools.gpgAgent = {
    enable = mkEnableOption "gpgAgent config";
  };

  config = mkIf cfg.enable {
    services.gpg-agent = {
      enable = true;

      # https://github.com/drduh/config/blob/master/gpg-agent.conf
      # https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
      enableSshSupport = true;
      defaultCacheTtl = 60;
      maxCacheTtl = 120;
      pinentryFlavor = "gtk2";
      extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
    };
  };
}
