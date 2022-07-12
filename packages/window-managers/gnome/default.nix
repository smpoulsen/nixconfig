{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.sylvie.packages.window-managers.gnome;

in {
  imports = [
    ./paperwm
  ];

  options.sylvie.packages.window-managers.gnome = {
    enable = mkEnableOption "Gnome config";

    fullGnome = mkOption {
      type = types.bool;
      default = false;
      description = "Full gnome wm setup";
    };
  };

  config = mkIf cfg.enable {
    # xsession.windowManager.gnome = {
    #   enable = cfg.fullGnome;
    # };
  };
}
