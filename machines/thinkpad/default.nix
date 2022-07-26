{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  imports = [ ../../users/sylvie ../../packages ];

  users.sylvie = {
    enable = true;
    standalone = true;
    system = "standalone";
    username = "spoulsen";
  };

  sylvie.packages = {
    dev-tools = {
      git = {
        email = "sylvie.poulsen@philips.com";
        gpg.sign = false;
      };

      gpg.enable = false;

      virtualization.docker-compose.enable = true;
    };

    languages = { ruby.enable = true; };

    misc = {
      gestures.enable = true;
      browsers.chromium.enable = true;
      communication = {
        obs.enable = true;
        teams.enable = true;
        slack.enable = true;
        thunderbird.enable = true;
      };
    };

    window-managers.gnome.paperwm.enable = true;
    #terminals.kitty.enable = true;
    terminals.libvterm.enable = true;
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
}
