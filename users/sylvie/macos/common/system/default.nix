{ config, lib, pkgs, ... }:

{
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.defaults = {
     dock = {
       autohide = false;
       orientation = "left";
       showhidden = false;
       mineffect = "genie";
       launchanim = true;
       show-process-indicators = true;
       tilesize = 36;
       static-only = true;
       mru-spaces = false;
       show-recents = false;
     };
     finder = {
       AppleShowAllExtensions = true;
       FXEnableExtensionChangeWarning = false;
       CreateDesktop = false; # disable desktop icons
     };
     NSGlobalDomain = {
       AppleInterfaceStyle = "Dark"; # set dark mode
     };
  };
}
