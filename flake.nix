{
  description = "The one and only MacBook Pro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # NixOS
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.home-manager.follows = "home-manager";

    # Nix Darwin
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-impermanence.url = "github:nix-community/impermanence?rev=4b3e914cdf97a5b536a889e939fb2fd2b043a170";

    # Miscellaneous
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    jvim.url = "path:./modules/jvim";

    sleep.url = "path:./modules/sleep";
    sleep.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
    self, 
    nixpkgs, 
    # NixOs
    nixos-hardware,
    impermanence,
    # Nix Darwin
    darwin, 
    mac-app-util, 
    # Home Manager
    home-manager,
    home-impermanence,
    # Miscellaneos
    spicetify-nix,
    stylix,
    quickshell,
    jvim,
    sleep,
    ... 
  }@inputs: {
    nixosConfigurations."sevs-kekbook-pro" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-hardware.nixosModules.apple-t2
        impermanence.nixosModules.impermanence
        sleep.nixosModules.t2sleep
        ./hosts/+kekbook.configuration.nix
        ./modules/brcm/brcm.nix
        ./modules/persistShadowHack/persistShadowHack.nix
        ./modules/bootstrap-user-systemd/bootstrap-user-systemd.nix
      ];
    };

    darwinConfigurations."sevs-macbook-pro" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        mac-app-util.darwinModules.default
        ./hosts/+mac.configuration.nix
      ];
    };

    homeConfigurations."severinnitsche" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-darwin";
      modules = [ 
        mac-app-util.homeManagerModules.default
        spicetify-nix.homeManagerModules.default
        jvim.homeManagerModules.default
        ./home/+severinnitsche.nix 
      ];
      extraSpecialArgs = { inherit inputs; };
    };

    homeConfigurations."severin" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        ./modules/bootstrap-home-manager/bootstrap-home-manager.nix
        "${home-impermanence}/home-manager.nix"
        spicetify-nix.homeManagerModules.default
        stylix.homeModules.stylix
        ./home/+severin.nix
      ];
      extraSpecialArgs = {
        inherit inputs; # required for spicetify
        quickshell = quickshell.packages."x86_64-linux".default;
      }; 
    };

  };
}
