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

  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.wvous-bl-corner = 11;
  system.defaults.dock.wvous-br-corner = 1;
  system.defaults.finder.FXDefaultSearchScope = "SCcf";
  system.defaults.screencapture.show-thumbnail = false;
  system.defaults.CustomUserPreferences = {
    "com.apple.Safari" = {
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
    };
  };
  system.defaults.LaunchServices.LSQuarantine = false;
  system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  system.defaults.NSGlobalDomain."com.apple.trackpad.forceClick" = false;

  system.stateVersion = 5;
}
