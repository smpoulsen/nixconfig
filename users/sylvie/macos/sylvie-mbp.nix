{ config, lib, pkgs, ... }:

{
  imports = [
    ./default.nix
  ];
  home-manager.users.sylvie = { config, pkgs, ... }: {
    home = {
      sessionVariables = {
        BROWSER = "firefox";
      };
    };

    home.packages = with pkgs; [
      # Apps
      #brave

      # Dev
      mkcert
      nss
      podman
      skopeo

      # Fonts

      # Sys tools
    ];
  };
}
