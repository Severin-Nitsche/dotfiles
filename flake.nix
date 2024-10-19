{
  description = "The one and only MacBook Pro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {
    darwinConfigurations."sevs-macbook-pro" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [ ./hosts/sevs-macbook-pro/configuration.nix ];
    };

    homeConfigurations."severinnitsche" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-darwin";
      modules = [ ./home/severinnitsche/home.nix ];
    };
  };
}
