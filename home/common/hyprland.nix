{ pkgs, ... }: {

  imports = [];

  options = {};

  config = {
    # Manage Hyprland
    wayland.windowManager.hyprland.enable = true;
    programs.kitty.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, uwsm app -- kitty"
        "$mod, M, exec, uwsm stop" # Do not use exit with uwsm
      ];
      input = {
         kb_layout = "de";
      };
    };
    wayland.windowManager.hyprland.systemd.enable = false; # uwsm compatibility
  };

}
