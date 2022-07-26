{ lib, pkgs, config, ... }:
with lib;

let cfg = config.sylvie.packages.terminals.libvterm;

in {
  options.sylvie.packages.terminals.libvterm = {
    enable = mkEnableOption "libvterm";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.libvterm ]; };
}
