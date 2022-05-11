{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.sylvie.packages.window-managers.i3;
  mod = "Mod4";
in {
  options.sylvie.packages.window-managers.i3 = {
    enable = mkEnableOption "i3 config";
  };

  config = mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = {
        modifier = mod;
        bars = [ ];

        window.border = 2;

        gaps = {
          inner = 15;
          outer = 5;
        };

        # List definition is deprecated, but I
        # can't find what the expected attrset
        # looks like anywhere.
        fonts = ["Cascadia Code"];

        keybindings = lib.mkOptionDefault {
          "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
          # "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
          "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";

          # Open alacritty instead of xterm
          "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${mod}+b" = "exec ${pkgs.firefox}/bin/firefox";

          # Focus
          "${mod}+j" = "focus left";
          "${mod}+k" = "focus down";
          "${mod}+l" = "focus up";
          "${mod}+semicolon" = "focus right";

          # Modes
          "${mod}+Shift+p" = "mode power-mgmt";
          "${mod}+Shift+n" = "mode nixos";

          # Move
          "${mod}+Shift+j" = "move left";
          "${mod}+Shift+k" = "move down";
          "${mod}+Shift+l" = "move up";
          "${mod}+Shift+semicolon" = "move right";
        };

        modes = {
          resize = {
            Down = "resize grow height 10 px or 10 ppt";
            Escape = "mode default";
            Left = "resize shrink width 10 px or 10 ppt";
            Return = "mode default";
            Right = "resize grow width 10 px or 10 ppt";
            Up = "resize shrink height 10 px or 10 ppt";
          };

          power-mgmt = {
            "${mod}+p" = "exec systemctl shutdown";
            "${mod}+r" = "exec systemctl reboot";
            "${mod}+s" = "exec systemctl suspend";
            Return = "mode default";
            Escape = "mode default";
          };

          nixos = {
            "${mod}+s" = "exec alacritty --hold --command 'sudo nixos-rebuild switch'";
            Return = "mode default";
            Escape = "mode default";
          };
        };

        startup = [
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
        ];
      };
    };
  };
}
