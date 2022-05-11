{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.amethyst;
  amethyst = pkgs.callPackage ./amethyst.nix;
in {
  options.programs.amethyst = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
      Installs Amethyst
      '';
    };

    package = mkOption {
      type = types.package;
      default = (import ./amethyst.nix { inherit pkgs; });
      defaultText = literalExpression "pkgs.amethyst";
      description = "The Amethyst package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      amethyst
    ];
  };
}
