{
  description = "The one and only MacBook Pro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin }: {
    darwinConfigurations."sevs-macbook-pro" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [ ./hosts/sevs-macbook-pro/configuration.nix ];
    };
  };
}
