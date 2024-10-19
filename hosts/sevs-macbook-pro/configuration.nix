{ pkgs, ... }: {

  # Enable nix daemon
  services.nix-daemon.enable = true;
  # Never more '--experimental-features'
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Apparently needed for some sourcing magic
  programs.zsh.enable = true;

  # Homebrew -- needs to be installed separately
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true; # slow but i might as well
  homebrew.onActivation.upgrade = true;
  homebrew.casks = [
    "discord" # Didn't even knew this existed
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = 5;
}
