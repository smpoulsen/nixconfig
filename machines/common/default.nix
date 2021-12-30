{ config, lib, pkgs, ... }:

{
  imports = [];

  # Set your time zone.
  time.timeZone = "America/New_York";

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    vim
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nixpkgs.config.allowUnfree = true;
}
