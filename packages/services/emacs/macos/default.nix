{ config, lib, pkgs, ... }:

{
  environment.launchDaemons.emacs.enable = true;
  launchd.daemons.emacs = {
    serviceConfig = {
      Label = "gnu.emacs.daemon";
      Program = pkgs.emacs;
      ProgramArguments = "--daemon";
      RunAtLoad = true;
    };
  };
}
