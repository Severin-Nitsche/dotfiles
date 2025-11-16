{
  programs.librewolf = {
    enable = true;
    languagePacks = [ "de" ];
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
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
