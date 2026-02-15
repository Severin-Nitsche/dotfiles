{
  # Enable Upower (for quickshell)
  services.upower.enable = true;

  # Enable HYPRLAND
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  security.pam.services.hyprlock.enable = true;

  # Recommended for uwsm
  services.dbus.implementation = "broker"; 
}
