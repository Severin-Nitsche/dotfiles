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
  homebrew.onActivation.cleanup = "zap"; # kills everything unmanaged
  homebrew.casks = [
    # "discord" # Didn't even knew this existed
    "ukelele"
    "makemkv"
    "minecraft"
    "curseforge"
    "steam"
    "firefox"
    "tor-browser"
    "sf-symbols"
    # "intellij-idea"
    # "webstorm"
    # "visual-studio-code"
    "bitwarden"
    "logi-options+"
    # "iterm2"
    "rustdesk"
    # "geogebra"
    # "spotify"
    "whatsapp"
    # "signal"
    # "postman"
    "obs"
    # "anki"
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = 5;
}
