{
  description = "Sylvie darwin flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;

      hostname = "MACC02DC24EMD6N";
      homeManagerConfig = ../../../users/sylvie/macos/sylvie-mbp.nix;

      nixpkgsConfig = {
        config = {
          allowBroken = true;
          allowUnsupportedSystem = true;
          allowUnfree = true;
        };
      };

    in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake  .
    darwinConfigurations = rec {
      ${hostname} = darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./darwin-configuration.nix
          home-manager.darwinModules.home-manager {
            nixpkgs = nixpkgsConfig;
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            imports = [homeManagerConfig];
          }
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
