{ config, pkgs, ... }: {

  users.users.sylvie = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  security.sudo.extraRules = [
    { users = [ "sylvie" ];
      commands = [
          { command = "ALL";
      options = [ "NOPASSWD" ];
      }
      ];
    }
  ];

  home-manager.users.sylvie = { config, pkgs, ... }: {
    imports = [
      ./home.nix
    ];
  };
}
