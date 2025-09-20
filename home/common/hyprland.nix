{ pkgs, ... }: {

  imports = [
    ./hyprlock/hyprlock.nix # Includes hypridle
    ./quickshell/quickshell.nix
  ];

  options = {};

  config = {
    home.packages = with pkgs; [ 
      rofi-wayland # TODO Change to rofi in the near future, when it is merged
      brightnessctl
      kdePackages.qtwayland # qt6
      libsForQt5.qt5.qtwayland # qt5
      nerd-fonts.symbols-only # Icons
      dunst
     ];

    fonts.fontconfig.enable = true; # Icons

    # Manage uwsm session variables (force Wayland)
    home.file.".config/uwsm/env".text = ''
      export GDK_BACKEND=wayland,x11,*
      export QT_QPA_PLATFORM="wayland;xcb"
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland
      export NIXOS_OZONE_WL=1
    '';

    # Manage Hyprland
    wayland.windowManager.hyprland.enable = true;
    services.hyprpolkitagent.enable = true;
    programs.kitty.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "CTRL";
      bind = [
        "$mod, Q, killactive"
        "$mod, return, exec, uwsm app -- kitty"
        "$mod, M, exec, uwsm stop" # Do not use exit with uwsm
        "$mod, space, exec, uwsm app -- rofi -show drun -run-command 'uwsm app -- {cmd}'"
        "$mod, L, exec, hyprlock"
        "$mod, 1, fullscreen, 0"
        "$mod, 2, fullscreen, 1"
        "$mod, 3, togglefloating, active"
        ", XF86KbdBrightnessDown, exec, brightnessctl set -c leds -d :white:kbd_backlight -e 20%-"
        ", XF86KbdBrightnessUp, exec, brightnessctl set -c leds -d :white:kbd_backlight -e +20%"
        ", XF86MonBrightnessDown, exec, brightnessctl set -c backlight -d intel_backlight -e 10%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set -c backlight -d intel_backlight -e +10%"
      ];

      layerrule = [
        "blur, quickshell"
      ];

      exec-once = [
        "uwsm app -- quickshell"
      ];
      
      input = {
         kb_layout = "de";
         kb_variant = "mac";
         kb_options = "caps:swapescape,caps:ctrl_modifier,lv3:alt_switch,altwin:ctrl_win";
         touchpad = {
           disable_while_typing = false;
           natural_scroll = true;
           clickfinger_behavior = true;
           scroll_factor = 0.8;
         };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_fingers = true;
        workspace_swipe_min_speed_to_force = 15;
        workspace_swipe_cancel_ratio = 0.05;
      };
    };
    wayland.windowManager.hyprland.systemd.enable = false; # uwsm compatibility
  };

}
