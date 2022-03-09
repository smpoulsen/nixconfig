{
  description = "Sylvie-mbp flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, darwin, nixpkgs }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .
    darwinConfigurations."sylvie-mbp" = darwin.lib.darwinSystem {
      modules = [
        ./darwin-configuration.nix
      ];
      system = "x86_64-darwin";
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."sylvie-mbp".pkgs;
  };
}
