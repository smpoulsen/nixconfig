{ lib, pkgs, config, ... }:
with lib;

let
  cfg = config.sylvie.packages.alacritty;

in {
  options.sylvie.packages.alacritty = {
    enable = mkEnableOption "alacritty config";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        font = {
          use_thin_strokes = true;
          size = 12.0;

          normal.famiy = "Cascadia Code";
          bold.famiy = "Cascadia Code";
          italic.famiy = "Cascadia Code";
        };

        cursor.style = "Block";

        shell = {
          program = "fish";
        };

        # Nord
        colors = {
          primary = {
            background = "0x2E3440";
            foreground = "0xD8DEE9";
          };

          cursor = {
            text = "0x2E3440";
            cursor = "0xD8DEE9";
          };

          normal = {
            black = "0x3B4252";
            red = "0xBF616A";
            green = "0xA3BE8C";
            yellow = "0xEBCB8B";
            blue = "0x81A1C1";
            magenta = "0xB48EAD";
            cyan = "0x88C0D0";
            white = "0xE5E9F0";
          };

          bright = {
            black = "0x4C566A";
            red = "0xBF616A";
            green = "0xA3BE8C";
            yellow = "0xEBCB8B";
            blue = "0x81A1C1";
            magenta = "0xB48EAD";
            cyan = "0x8FBCBB";
            white = "0xECEFF4";
          };
        };
      };
    };
  };
}