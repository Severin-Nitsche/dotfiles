{
  programs.librewolf = {
    enable = true;
    languagePacks = [ "de" ];
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      search = {
        order = [ "noai" ];
        default = "noai";
        privateDefault = "noai";
        force = true;
        engines = {
          noai = {
            name = "DuckDuckGo no AI";
            urls = [{template = "https://noai.duckduckgo.com/?q={searchTerms}";}];
            iconMapObj."16" = "https://no-ai-icon.com/favicon.ico";
            definedAliases = [ "@noai" ];
          };
          unicode = {
            name = "Unicode";
            urls = [{template = "https://www.compart.com/de/unicode/search?q={searchTerms}";}];
            iconMapObj."16" = "https://www.compart.com/en/unicode/images/icon/favicon.ico";
            definedAliases = [ "@u" ];
          };
          context = {
            name = "ConTeXt";
            urls = [{template = "https://wiki.contextgarden.net/index.php?search={searchTerms}";}];
            iconMapObj."16" = "https://wiki.contextgarden.net/favicon.ico";
            definedAliases = [ "@context" ];
          };
          nix-packages = {
            name = "Nix Packages";
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}";}
              ];
            }];
            iconMapObj."16" = "https://search.nixos.org/favicon.png";
            definedAliases = [ "@nixpkgs" "@nix" ];
          };
        };
      };
      settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.disable-workspace-management" = true;
        "intl.locale.requested" = "de";
        # Get rid of annoying prompts
        "browser.translations.enable" = false;
        "privacy.spoof_english" = 2;
        # "intl.accept_languages" = "en-US, en";
      };
    };
  };
}
