{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  imports = [
    ../../users/sylvie
    ../../packages
    ../../packages/modules/emacs/nixos.nix
    ../../packages/modules/alacritty
  ];

  users.sylvie = {
    enable = true;
    standalone = true;
    username = "spoulsen";
  };

  sylvie.packages = {
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
}
