{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.sylvie.packages.window-managers.gnome;
in {
  options.sylvie.packages.window-managers.gnome = {
    enable = mkEnableOption "Gnome config";

    fullGnome = mkOption {
      type = types.bool;
      default = false;
      description = "Full gnome wm setup";
    };

    paperWm = mkOption {
      type = types.bool;
      default = false;
      description = "paperWM";
    };
  };

  config = mkIf cfg.enable {
    # xsession.windowManager.gnome = {
    #   enable = cfg.fullGnome;
    # };
    home.packages = (if cfg.paperWm then [pkgs.gnomeExtensions.paperwm] else []);
  };
}
