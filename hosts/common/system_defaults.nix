{ ... }: {

  imports = [];

  options = {};

  config = {
    system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
    system.defaults.dock.minimize-to-application = true;
    system.defaults.dock.wvous-bl-corner = 11;
    system.defaults.dock.wvous-br-corner = 1;
    system.defaults.finder.FXDefaultSearchScope = "SCcf";
    system.defaults.screencapture.show-thumbnail = false;
    system.defaults.CustomUserPreferences = {
      "com.apple.Safari" = {
        "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled"
        = true; 
      };
      "com.apple.TextEdit".RichText = false;
    };
    system.defaults.LaunchServices.LSQuarantine = false;
    system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
    system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
    system.defaults.finder.AppleShowAllExtensions = true;
    system.defaults.finder.FXEnableExtensionChangeWarning = false;
    system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    # system.defaults.NSGlobalDomain."com.apple.trackpad.forceClick" = false;
  };

}
