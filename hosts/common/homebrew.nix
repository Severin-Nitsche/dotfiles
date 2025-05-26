{ ... }: {

  imports = [];

  options = {};

  config = {
  
    # Homebrew -- needs to be installed separately
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
      # "logi-options+"
      "rustdesk"
      "whatsapp"
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
      Excel = 462058435;
      Powerpoint = 462062816;
      Wireguard = 1451685025;
      "DuckDuckGo Privacy for Safari" = 1482920575;
    };
 
  };

}
