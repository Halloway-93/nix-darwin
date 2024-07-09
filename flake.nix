{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#H
    darwinConfigurations."H" = nix-darwin.lib.darwinSystem {
      modules = [
        ./darwin.nix
        {nixpkgs.config.allowUnfree = true;}
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mango = import ./home.nix;
          users.users."mango" = {
            home = "/Users/mango";
            name = "mango";
          };
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    # darwinPackages = self.darwinConfigurations."H".pkgs;
  };
}
