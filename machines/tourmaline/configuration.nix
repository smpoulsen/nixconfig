{ config, lib, pkgs, ... }:

{
  imports = [
    (import <home-manager/nixos>)
    /persist/nixconfig/users/nixos.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev"; # "nodev" for efi only
      enableCryptodisk = true;
      useOSProber = true;
    };
    systemd-boot.enable = true;
    generationsDir.copyKernels = true;
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  networking.hostName = "tourmaline"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    vim
    wget
    wl-clipboard
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nixpkgs.config.allowUnfree = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  #
  # Enable pcscd for yubikey
  services.pcscd.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
