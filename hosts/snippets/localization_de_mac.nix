{
  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  # console.keyMap = "de";
  console.useXkbConfig = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "de";
  services.xserver.xkb.variant = "mac";
  # services.xserver.xkb.options = "lv3:alt_switch"; # Switching to ttyX impossible (ctrl+lalt+FX)
}
