{
  description = "The one and only MacBook Pro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # NixOS
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    # Nix Darwin
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Miscellaneous
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    jvim.url = "path:./modules/jvim";
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
    # Miscellaneos
    spicetify-nix,
    stylix,
    quickshell,
    jvim,
    ... 
  }@inputs: {
    nixosConfigurations."sevs-kekbook-pro" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-hardware.nixosModules.apple-t2
        impermanence.nixosModules.impermanence
        ./hosts/sevs-kekbook-pro/configuration.nix
        ./modules/brcm/brcm.nix
        ./modules/persistShadowHack/persistShadowHack.nix
        ./modules/bootstrap-user-systemd/bootstrap-user-systemd.nix
      ];
    };

    darwinConfigurations."sevs-macbook-pro" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
       mac-app-util.darwinModules.default
       ./hosts/sevs-macbook-pro/configuration.nix 
     ];
    };

    homeConfigurations."severinnitsche" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-darwin";
      modules = [ 
        mac-app-util.homeManagerModules.default
        spicetify-nix.homeManagerModules.default
        jvim.homeManagerModules.default
        ./home/severinnitsche/home.nix 
      ];
      extraSpecialArgs = { inherit inputs; };
    };

    homeConfigurations."severin" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        ./modules/bootstrap-home-manager/bootstrap-home-manager.nix
        "${impermanence}/home-manager.nix"
        spicetify-nix.homeManagerModules.default
        stylix.homeModules.stylix
        jvim.homeManagerModules.default
        ./home/severin/home.nix
      ];
      extraSpecialArgs = {
        inherit inputs; # required for spicetify
        quickshell = quickshell.packages."x86_64-linux".default;
      }; 
    };

  };
}
