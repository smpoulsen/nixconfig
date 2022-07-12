{
  description = "Sylvie Thinkpad flake";

  inputs = {
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, flake-utils, nixpkgs, home-manager, ... }@inputs:
    let
      homeManagerConfig = ../../../users/sylvie/macos/sylvie-mbp.nix;

      nixpkgsConfig = {
        config = {
          allowBroken = true;
          allowUnsupportedSystem = true;
          allowUnfree = true;
        };
      };

      pkgsForSystem = system: import nixpkgs {
        overlays = [
        ];
        inherit system;
      };

      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        system = args.system or "x86_64-linux";
        pkgs = pkgsForSystem system;
      } // args);

    in flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: rec {
      legacyPackages = pkgsForSystem system;
    }) // {

      homeConfigurations.thinkpad = mkHomeConfiguration {
        configuration = import ./default.nix;
        username = "spoulsen";
        homeDirectory = "/home/spoulsen";
        extraSpecialArgs = {
          nixpkgs = nixpkgsConfig;
        };
      };
    };
}
