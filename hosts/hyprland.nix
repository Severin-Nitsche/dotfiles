{ pkgs, ... }: {
  # Enable Upower (for quickshell)
  services.upower.enable = true;

  # Enable HYPRLAND
  programs.hyprland.enable = true;
  programs.hyprland.package = pkgs.hyprland;

  security.pam.services.hyprlock.enable = true;

  # Enable udisks2
  services.udisks2.enable = true;
}
