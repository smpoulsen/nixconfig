{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  imports = [
    ../../users/sylvie
    ../../packages
  ];

  users.sylvie = {
    enable = true;
    standalone = true;
    system = "standalone";
    username = "spoulsen";
  };

  sylvie.packages = {
    git = {
      email = "sylvie.poulsen@philips.com";
      gpg.sign = false;
    };

    window-managers.gnome = {
      enable = true;
      paperWm = true;
    };

    communication = {
      teams.enable = true;
      slack.enable = true;
    };
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
}
