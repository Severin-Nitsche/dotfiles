{ ... }: {

  imports = [];

  options = {};

  config = {
  
    # Homebrew -- needs to be installed separately
    environment.variables.HOMEBREW_NO_ANALYTICS = "1";
    homebrew.enable = true;
    homebrew.onActivation.autoUpdate = true; # slow but i might as well
    homebrew.onActivation.upgrade = true;
    homebrew.onActivation.cleanup = "zap"; # kills everything unmanaged
    homebrew.casks = [
      "ukelele"
      "makemkv"
      # "minecraft"
      # "curseforge"
      # "steam"
      "firefox"
      "tor-browser"
      "sf-symbols"
      # "spotify"
      # "logi-options+"
      "rustdesk"
      "obs"
      "duckduckgo"
      "microsoft-word"
    ];
  
    homebrew.masApps = {
      XCode = 497799835;
      Bitwarden = 1352778147; # Even less control >:
      GoodNotes = 1444383602;
      Flow = 1423210932;
      Pages = 409201541;
      Keynote = 409183694;
      Excel = 462058435;
      Powerpoint = 462062816;
      Wireguard = 1451685025;
      "DuckDuckGo Privacy for Safari" = 1482920575;
    };
 
  };

}
