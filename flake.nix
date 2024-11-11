{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixos-hardware, impermanence, home-manager, ... }: {

    nixosConfigurations."sevs-kekbook-pro" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        impermanence.nixosModules.impermanence
        ./hosts/sevs-kekbook-pro/configuration.nix
        nixos-hardware.nixosModules.apple-t2
        ./derivs/brcm/brcm.nix
        ./derivs/impermanence/impermanence.nix
        ./derivs/persistShadowHack/persistShadowHack.nix
      ];
    };

    homeConfigurations."severin" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [ ./home/severin/home.nix ];
    };

  };
}
