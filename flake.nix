{
  description = "The one and only MacBook Pro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    mac-app-util.url = "github:hraban/mac-app-util";

    jvim.url = "path:./modules/jvim";
    # lfc.url = "path:./derivs/latex-fast-compile";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
    self, 
    nixpkgs, 
    darwin, 
    home-manager, 
    mac-app-util, 
    spicetify-nix,
    jvim,
    # lfc,
    ... 
  }@inputs: {
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
  };
}
