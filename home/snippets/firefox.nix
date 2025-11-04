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
      };
    };
  };
}
