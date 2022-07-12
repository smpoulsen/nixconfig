{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.sylvie.packages.window-managers.gnome.paperwm;

  userConf = builtins.readFile ./config/user.js;
  metadata = builtins.readFile ./config/metadata.json;
  keybindings = builtins.readFile ./config/keybindings.txt;

  loadKeybindings = ''
    dconf load /org/gnome/shell/extensions/paperwm/keybindings/ < ${config.xdg.configHome}/papwerwm/keybindings.txt
  '';

in {
  options.sylvie.packages.window-managers.gnome.paperwm = {
    enable = mkEnableOption "PaperWM config";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.gnomeExtensions.paperwm ];
    xdg = {
      enable = true;
      configFile = {
        "paperwm/user.js" = {
          text = "${userConf}";
        };
        "paperwm/metadata.js" = {
          text = "${metadata}";
        };
        "paperwm/keybindings.txt" = {
          text = "${keybindings}";
          onChange =
            "${pkgs.writeShellScript "load-paper-keybindings" loadKeybindings}";
        };
      };
    };
  };
}
