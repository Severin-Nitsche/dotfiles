{ pkgs, ... }: {

  imports = [];

  options = {};

  config = {
    home.packages = with pkgs; [ 
      rofi-wayland # TODO Change to rofi in the near future, when it is merged
      dunst
     ];

    # Manage Hyprland
    wayland.windowManager.hyprland.enable = true;
    programs.kitty.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, killactive"
        "$mod, K, exec, uwsm app -- kitty"
        "$mod, M, exec, uwsm stop" # Do not use exit with uwsm
        "$mod, space, exec, uwsm app -- rofi -show drun -run-command 'uwsm app -- {cmd}'"
      ];
      
      input = {
         kb_file = "./custom.xkb";
         touchpad = {
           natural_scroll = true;
           clickfinger_behavior = true;
         };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_fingers = true;
        workspace_swipe_min_speed_to_force = 15;
        workspace_swipe_cancel_ratio = 0.05;
      };
    };
    home.file.".config/hypr/custom.xkb".source = ./custom.xkb;
    wayland.windowManager.hyprland.systemd.enable = false; # uwsm compatibility
  };

}
