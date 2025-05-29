{ pkgs, ... }: {

  imports = [ # Refactor some parts into separate files
    ../common/homebrew.nix
    ../common/system_defaults.nix
  ];

  options = {};

  config = {
    # Never more '--experimental-features'
    # nix.enable = false;
    nix.settings.experimental-features = [ 
      "nix-command" 
      "flakes" 
    ];
  
    # Some stuff in nix darwin is deprecated / up to change
    # For now, I need this for compatibility
    system.primaryUser = "severinnitsche";
 
    # System Packages
    environment.systemPackages = with pkgs; [
      home-manager
    ];
  
    # No more password for sudo
    security.pam.services.sudo_local.touchIdAuth = true;

    system.stateVersion = 5;
  };
}
